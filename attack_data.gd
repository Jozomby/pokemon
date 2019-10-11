static func getAttack(name):
	var attacks = {
		"STRINGSHOT": {
			"id": 20,
			"internal_name": "STRINGSHOT",
			"name": "String Shot",
			"power": 0,
			"type": "BUG",
			"kind": "Status",
			"accuracy":95,
			"pp": 40,
			"contact": false,
			"target": "ALL_ADJACENT_FOES",
			"effects": [
				{
					"type": "STAT",
					"stat": "speed",
					"direction": "down",
					"num_stages": 1,
					"target": "opponent"
				}
			],
			"description": "The foe is bound with silk blown from the user's mouth. This silk reduces the target's Speed."
		},
		"THUNDERSHOCK": {
			"id": 79,
			"internal_name": "THUNDERSHOCK",
			"name": "Thunder Shock",
			"power": 40,
			"type": "ELECTRIC",
			"kind": "Special",
			"accuracy": 100,
			"pp": 30,
			"contact": false,
			"target": "SINGLE_ADJACENT",
			"effects": [
				{
					"type": "STATUS",
					"status": "PARALYZE",
					"rate": 10,
					"target": "opponent"
				}
			],
			"description": "A jolt of electricity is hurled at the foe to inflict damage. It may also leave the target with paralysis."
		},
		"VINEWHIP": {
			"id": 208,
			"internal_name": "VINEWHIP",
			"name": "Vine Whip",
			"power": 35,
			"type": "GRASS",
			"kind": "Physical",
			"accuracy": 100,
			"pp": 15,
			"contact": true,
			"target": "SINGLE_ADJACENT",
			"effects": [],
			"description": "The target is struck with slender, whiplike vines to inflict damage."
		},
		"LEECHSEED": {
			"id": 217,
			"internal_name": "LEECHSEED",
			"name": "Leech Seed",
			"power": 0,
			"type": "GRASS",
			"kind": "Status",
			"accuracy": 90,
			"pp": 10,
			"contact": false,
			"target": "SINGLE_ADJACENT",
			"effects": [
				{
					"type": "SEEDED",
					"target": "opponent"
				}
			],
			"description": "A seed is planted on the target. It steals some HP from the target every turn."
		},
		"SANDATTACK": {
			"id": 238,
			"internal_name": "SANDATTACK",
			"name": "Sand Attack",
			"power": 0,
			"type": "GROUND",
			"kind": "Status",
			"accuracy": 100,
			"pp": 15,
			"contact": false,
			"target": "SINGLE_ADJACENT",
			"effects": [
				{
					"type": "STAT",
					"stat": "accuracy",
					"direction": "down",
					"num_stages": 1,
					"target": "opponent"
				}
			],
			"description": "Sand is hurled in the target's face, reducing its accuracy."
		},
		"TACKLE": {
			"id": 303,
			"internal_name": "TACKLE",
			"name": "Tackle",
			"power": 50,
			"type": "NORMAL",
			"kind": "Physical",
			"accuracy": 100,
			"pp": 35,
			"contact": true,
			"target": "SINGLE_ADJACENT",
			"effects": [],
			"description": "A physical attack in which the user charges and slams into the target with its whole body."
		},
		"GROWL": {
			"id": 368,
			"internal_name": "GROWL",
			"name": "Growl",
			"power": 0,
			"type": "NORMAL",
			"kind": "Status",
			"accuracy": 100,
			"pp": 40,
			"contact": false,
			"target": "ALL_ADJACENT_FOES",
			"effects": [
				{
					"type": "STAT",
					"stat": "attack",
					"direction": "down",
					"num_stages": 1,
					"target": "opponent"
				}
			],
			"description": "The user growls in an endearing way, making the foe less wary. The foe's Attack stat is lowered."
		},
		"TAILWHIP": {
			"id": 419,
			"internal_name": "TAILWHIP",
			"name": "Tail Whip",
			"power": 0,
			"type": "NORMAL",
			"kind": "Status",
			"accuracy": 100,
			"pp": 30,
			"contact": false,
			"target": "ALL_ADJACENT_FOES",
			"effects": [
				{
					"type": "STAT",
					"stat": "defense",
					"direction": "down",
					"num_stages": 1,
					"target": "opponent"
				}
			],
			"description": "The user wags its tail cutely, making opposing Pokémon less wary and lowering their Defense stat."
		}
	}
	return attacks[name]
	
static func getTypeId(name):
	var types = {
		"NORMAL": 0,
		"FIGHTING": 1,
		"FLYING": 2,
		"POISON": 3,
		"GROUND": 4,
		"ROCK": 5,
		"BUG": 6,
		"GHOST": 7,
		"STEEL": 8,
		"NONE": 9,
		"FIRE": 10,
		"WATER": 11,
		"GRASS": 12,
		"ELECTRIC": 13,
		"PSYCHIC": 14, 
		"ICE": 15,
		"DRAGON": 16,
		"DARK": 17,
		"SHADOW": 18
	}
	return types[name]
