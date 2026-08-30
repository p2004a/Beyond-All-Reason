#!/usr/bin/env bash
# Resolves what to build, asks the rapid build service to build it, and retries
# only the outcomes a retry can fix. Every input arrives in the environment,
# see action.yml.
set -euo pipefail

audience="${INPUT_AUDIENCE:-$INPUT_URL}"

# The first retry waits a minute, each next one twice as long, and we stop
# scheduling one once the waiting would pass the budget.
delay="${RETRY_DELAY:-60}"
max_delay="${RETRY_MAX_DELAY:-300}"
budget="${RETRY_BUDGET:-900}"

if [ -z "$INPUT_REF" ]; then
	commit="$GITHUB_SHA"
	branch="$INPUT_BRANCH"
	if [ -z "$branch" ]; then
		echo "::error::branch is required when ref is empty"
		exit 1
	fi
elif [ -z "${INPUT_REF//[0-9]/}" ]; then
	commit="$(gh api "repos/$GITHUB_REPOSITORY/pulls/$INPUT_REF" --jq .head.sha)"
	branch="${INPUT_BRANCH:-pr-$INPUT_REF}"
else
	commit="$(gh api "repos/$GITHUB_REPOSITORY/git/ref/heads/$INPUT_REF" --jq .object.sha)"
	branch="${INPUT_BRANCH:-br:$INPUT_REF}"
fi

token="$(curl -fsSL -H "Authorization: Bearer $ACTIONS_ID_TOKEN_REQUEST_TOKEN" \
	"$ACTIONS_ID_TOKEN_REQUEST_URL&audience=$audience" | jq -r .value)"

waited=0
attempt=1
while :; do
	echo "::group::Attempt $attempt: $INPUT_REPO:$branch at $commit"
	rc=0
	curl -sS --no-buffer --max-time 3600 -X POST \
		--get --data-urlencode "repo=$INPUT_REPO" --data-urlencode "branch=$branch" \
		--data-urlencode "commit=$commit" -D headers.txt \
		-H "Authorization: Bearer $token" "$INPUT_URL" \
		| tee build.log || rc=$?
	echo "::endgroup::"

	status="$(awk 'NR == 1 { print $2 }' headers.txt)"
	last="$(tail -n1 build.log)"

	# Only a build that published everything writes this line.
	case "$last" in
		"Build succeeded: "*)
			echo "$last"
			exit 0
			;;
		# The build ran and failed, so it fails the same way every time.
		"Build failed: "*)
			echo "::error::$last"
			exit 1
			;;
	esac
	case "$status" in
		400 | 401 | 403 | 505)
			echo "::error::rapid-build refused the request ($status), retrying will not help"
			exit 1
			;;
	esac

	reason="the build did not finish (HTTP $status, curl exit $rc)"
	if [ "$((waited + delay))" -gt "$budget" ]; then
		echo "::error::$reason, giving up after $attempt attempts"
		exit 1
	fi
	echo "::warning::$reason, retrying in ${delay}s"
	sleep "$delay"
	waited=$((waited + delay))
	attempt=$((attempt + 1))
	delay=$((delay * 2))
	if [ "$delay" -gt "$max_delay" ]; then
		delay="$max_delay"
	fi
done
