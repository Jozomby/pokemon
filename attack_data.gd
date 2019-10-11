static func getAttack(name):
	var attacks = {
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
