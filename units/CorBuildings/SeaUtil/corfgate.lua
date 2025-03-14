return {
	corfgate = {
		activatewhenbuilt = true,
		buildangle = 2048,
		builder = 0,
		buildpic = "CORFGATE.DDS",
		buildtime = 59000,
		canattack = false,
		canrepeat = false,
		category = "NOWEAPON",
		collisionvolumeoffsets = "0 -25 0",
		collisionvolumescales = "60 70 60",
		collisionvolumetype = "cyly",
		corpse = "DEAD",
		energycost = 74000,
		exemptcategory = "WEAPON",
		explodeas = "largeBuildingexplosiongeneric",
		footprintx = 4,
		footprintz = 4,
		health = 4100,
		idleautoheal = 5,
		idletime = 1800,
		maxacc = 0,
		maxdec = 0,
		maxslope = 10,
		metalcost = 4100,
		minwaterdepth = 16,
		noautofire = true,
		norestrict = 1,
		objectname = "Units/corfgate.s3o",
		onoffable = false,
		script = "Units/corfgate.cob",
		seismicsignature = 0,
		selfdestructas = "largeBuildingExplosionGenericSelfd",
		sightdistance = 600,
		speed = 0,
		turninplaceanglelimit = 140,
		turninplacespeedlimit = 0,
		turnrate = 0,
		unitname = "corfgate",
		waterline = 0,
		workertime = 0,
		customparams = {
			normaltex = "unittextures/cor_normal.dds",
			removestop = true,
			removewait = true,
			shield_color_mult = 0.8,
			shield_power = 5000,
			shield_radius = 600,
			subfolder = "CorBuildings/SeaUtil",
			techlevel = 2,
			unitgroup = "util",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.0 -2.91625976558e-05 -0.414924621582",
				collisionvolumescales = "57.2399902344 32.5033416748 63.3298492432",
				collisionvolumetype = "Box",
				damage = 1800,
				featuredead = "HEAP",
				footprintx = 2,
				footprintz = 2,
				height = 20,
				metal = 2296,
				object = "Units/corfgate_dead.s3o",
				reclaimable = true,
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumescales = "35.0 4.0 6.0",
				collisionvolumetype = "cylY",
				damage = 900,
				footprintx = 2,
				footprintz = 2,
				height = 4,
				metal = 918,
				object = "Units/cor2X2D.s3o",
				reclaimable = true,
				resurrectable = 0,
			},
		},
		sfxtypes = {
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "drone1",
			},
			select = {
				[1] = "drone1",
			},
		},
		weapondefs = {
			sea_repulsor = {
				avoidfeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				name = "NavalPlasmaRepulsor",
				soundhitwet = "sizzle",
				weapontype = "Shield",
				shield = {
					alpha = 0.17,
					armortype = "shields",
					energyupkeep = 0,
					force = 2.5,
					intercepttype = 1,
					power = 3250,
					powerregen = 52,
					powerregenenergy = 562.5,
					radius = 600,
					repulser = true,
					smart = true,
					startingpower = 1100,
					visiblerepulse = true,
					badcolor = {
						[1] = 1,
						[2] = 0.2,
						[3] = 0.2,
						[4] = 0.2,
					},
					goodcolor = {
						[1] = 0.2,
						[2] = 1,
						[3] = 0.2,
						[4] = 0.17,
					},
				},
			},
		},
		weapons = {
			[1] = {
				def = "SEA_REPULSOR",
				onlytargetcategory = "NOTSUB",
			},
		},
	},
}
