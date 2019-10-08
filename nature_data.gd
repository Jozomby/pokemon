static func getNature(id):
	var natures = {
		0: {
			"name": "Hardy",
			"up": "attack",
			"down": "attack"
		},
		1: {
			"name": "Lonely",
			"up": "attack",
			"down": "defense"
		},
		2: {
			"name": "Adamant",
			"up": "attack",
			"down": "special_attack"
		},
		3: {
			"name": "Naughty",
			"up": "attack",
			"down": "special_defense"
		},
		4: {
			"name": "Brave",
			"up": "attack",
			"down": "speed"
		},
		5: {
			"name": "Bold",
			"up": "defense",
			"down": "attack"
		},
		6: {
			"name": "Docile",
			"up": "defense",
			"down": "defense"
		},
		7: {
			"name": "Impish",
			"up": "defense",
			"down": "special_attack"
		},
		8: {
			"name": "Lax",
			"up": "defense",
			"down": "special_defense"
		},
		9: {
			"name": "Relaxed",
			"up": "defense",
			"down": "speed"
		},
		10: {
			"name": "Modest",
			"up": "special_attack",
			"down": "attack"
		},
		11: {
			"name": "Mild",
			"up": "special_attack",
			"down": "defense"
		},
		12: {
			"name": "Bashful",
			"up": "special_attack",
			"down": "special_attack"
		},
		13: {
			"name": "Rash",
			"up": "special_attack",
			"down": "special_defense"
		},
		14: {
			"name": "Quiet",
			"up": "special_attack",
			"down": "speed"
		},
		15: {
			"name": "Calm",
			"up": "special_defense",
			"down": "attack"
		},
		16: {
			"name": "Gentle",
			"up": "special_defense",
			"down": "defense"
		},
		17: {
			"name": "Careful",
			"up": "special_defense",
			"down": "special_attack"
		},
		18: {
			"name": "Quirky",
			"up": "special_defense",
			"down": "special_defense"
		},
		19: {
			"name": "Sassy",
			"up": "special_defense",
			"down": "speed"
		},
		20: {
			"name": "Timid",
			"up": "speed",
			"down": "attack"
		},
		21: {
			"name": "Hasty",
			"up": "speed",
			"down": "defense"
		},
		22: {
			"name": "Jolly",
			"up": "speed",
			"down": "special_attack"
		},
		23: {
			"name": "Naive",
			"up": "speed",
			"down": "special_defense"
		},
		24: {
			"name": "Serious",
			"up": "speed",
			"down": "speed"
		}
	}
	return natures[id]
