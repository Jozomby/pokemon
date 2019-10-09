static func getPokemon(id):
	var pokedata = {
		1: {
			"Id": 1,
			"Name": "Bulbasaur",
			"InternalName": "BULBASAUR",
			"Type1": "GRASS",
			"Type2": "POISON",
			"BaseStats": [45,49,49,45,65,65],
			"GenderRate": "FemaleOneEighth",
			"GrowthRate": "Parabolic",
			"BaseEXP": 64,
			"EffortPoints": [0,0,0,0,1,0],
			"Rareness": 45,
			"Happiness": 70,
			"Abilities": ["OVERGROW"],
			"HiddenAbility": "CHLOROPHYLL",
			"Moves": [
				{"Level": 1, "Move": "TACKLE"},
				{"Level": 3, "Move": "GROWL"},
				{"Level": 7, "Move": "LEECHSEED"},
				{"Level": 9, "Move": "VINEWHIP"},
				{"Level": 13, "Move": "POISONPOWDER"},
				{"Level": 13, "Move": "SLEEPPOWDER"},
				{"Level": 15, "Move": "TAKEDOWN"},
				{"Level": 19, "Move": "RAZORLEAF"},
				{"Level": 21, "Move": "SWEETSCENT"},
				{"Level": 25, "Move": "GROWTH"},
				{"Level": 27, "Move": "DOUBLEEDGE"},
				{"Level": 31, "Move": "WORRYSEED"},
				{"Level": 33, "Move": "SYNTHESIS"},
				{"Level": 37, "Move": "SEEDBOMB"}
			],
			"EggMoves": ["AMNESIA","CHARM","CURSE","ENDURE","GIGADRAIN","GRASSWHISTLE","INGRAIN","LEAFSTORM","MAGICALLEAF","NATUREPOWER","PETALDANCE","POWERWHIP","SKULLBASH","SLUDGE"],
			"Compatibility": ["Monster","Grass"],
			"StepsToHatch": 5355,
			"Height": 0.7,
			"Weight": 6.9,
			"Color": "Green",
			"Shape": 8,
			"Habitat": "Grassland",
			"RegionalNumbers": [1,231],
			"Kind": "Seed",
			"Pokedex": "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.",
			"BattlerPlayerY": 0,
			"BattlerEnemyY": 27,
			"BattlerAltitude": 0,
			"Evolutions": [
				{"InternalName": "IVYSAUR", "Method": "Level", "Level": 16}
			]
		},
		10: {
			"Id": 10,
			"Name": "Caterpie",
			"InternalName": "CATERPIE",
			"Type1": "BUG",
			"BaseStats": [45,30,35,45,20,20],
			"GenderRate": "Female50Percent",
			"GrowthRate": "Medium",
			"BaseEXP": 39,
			"EffortPoints": [1,0,0,0,0,0],
			"Rareness": 255,
			"Happiness": 70,
			"Abilities": ["SHIELDDUST"],
			"HiddenAbility": "RUNAWAY",
			"Moves": [
				{"Level": 1, "Move": "TACKLE"},
				{"Level": 1, "Move": "STRINGSHOT"},
				{"Level": 15, "Move": "BUGBITE"}
			],
			"Compatibility": ["Bug"],
			"StepsToHatch": 4080,
			"Height": 0.3,
			"Weight": 2.9,
			"Color": "Green",
			"Shape": 14,
			"Habitat": "Forest",
			"RegionalNumbers": [10,24],
			"Kind": "Worm",
			"Pokedex": "Its voracious appetite compels it to devour leaves bigger than itself without hesitation. It releases a terribly strong odor from its antennae.",
			"BattlerPlayerY": 0,
			"BattlerEnemyY": 27,
			"BattlerAltitude": 0,
			"Evolutions": [
				{"InternalName": "METAPOD", "Method": "Level", "Level": 7}
			]
		},
		16: {
			"Id": 16,
			"Name": "Pidgey",
			"InternalName": "PIDGEY",
			"Type1": "NORMAL",
			"Type2": "FLYING",
			"BaseStats": [40,45,40,56,35,35],
			"GenderRate": "Female50Percent",
			"GrowthRate": "Parabolic",
			"BaseEXP": 50,
			"EffortPoints": [0,0,0,1,0,0],
			"Rareness": 255,
			"Happiness": 70,
			"Abilities": ["KEENEYE","TANGLEDFEET"],
			"HiddenAbility": "BIGPECKS",
			"Moves": [
				{"Level": 1, "Move": "TACKLE"},
				{"Level": 5, "Move": "SANDATTACK"},
				{"Level": 9, "Move": "GUST"},
				{"Level": 13, "Move": "QUICKATTACK"},
				{"Level": 17, "Move": "WHIRLWIND"},
				{"Level": 21, "Move": "TWISTER"},
				{"Level": 25, "Move": "FEATHERDANCE"},
				{"Level": 29, "Move": "AGILITY"},
				{"Level": 33, "Move": "WINGATTACK"},
				{"Level": 37, "Move": "ROOST"},
				{"Level": 41, "Move": "TAILWIND"},
				{"Level": 45, "Move": "MIRRORMOVE"},
				{"Level": 49, "Move": "AIRSLASH"},
				{"Level": 53, "Move": "HURRICANE"}
			],
			"EggMoves": ["AIRCUTTER","AIRSLASH","BRAVEBIRD","DEFOG","FEINTATTACK","FORESIGHT","PURSUIT","STEELWING","UPROAR"],
			"Compatibility": ["Flying"],
			"StepsToHatch": 4080,
			"Height": 0.3,
			"Weight": 1.8,
			"Color": "Brown",
			"Shape": 9,
			"Habitat": "Forest",
			"RegionalNumbers": [16,10],
			"Kind": "Tiny Bird",
			"Pokedex": "It has an extremely sharp sense of direction. It can unerringly return home to its nest, however far it may be removed from its familiar surroundings.",
			"BattlerPlayerY": 0,
			"BattlerEnemyY": 23,
			"BattlerAltitude": 0,
			"Evolutions": [
				{"InternalName": "PIDGEOTTO", "Method": "Level", "Level": 18}
			]
		},
		25: {
			"Id": 25,
			"Name": "Pikachu",
			"InternalName": "PIKACHU",
			"Type1": "ELECTRIC",
			"BaseStats": [35,55,30,90,50,40],
			"GenderRate": "Female50Percent",
			"GrowthRate": "Medium",
			"BaseEXP": 105,
			"EffortPoints": [0,0,0,2,0,0],
			"Rareness": 190,
			"Happiness": 70,
			"Abilities": ["STATIC"],
			"HiddenAbility": "LIGHTNINGROD",
			"Moves": [
				{"Level": 1, "Move": "GROWL"},
				{"Level": 1, "Move": "THUNDERSHOCK"},
				{"Level": 5, "Move": "TAILWHIP"},
				{"Level": 10, "Move": "THUNDERWAVE"},
				{"Level": 13, "Move": "QUICKATTACK"},
				{"Level": 18, "Move": "ELECTROBALL"},
				{"Level": 21, "Move": "DOUBLETEAM"},
				{"Level": 26, "Move": "SLAM"},
				{"Level": 29, "Move": "THUNDERBOLT"},
				{"Level": 34, "Move": "FEINT"},
				{"Level": 37, "Move": "AGILITY"},
				{"Level": 42, "Move": "DISCHARGE"},
				{"Level": 45, "Move": "LIGHTSCREEN"},
				{"Level": 50, "Move": "THUNDER"}
			],
			"Compatibility": ["Field","Fairy"],
			"StepsToHatch": 2805,
			"Height": 0.4,
			"Weight": 6.0,
			"Color": "Yellow",
			"Shape": 8,
			"Habitat": "Forest",
			"RegionalNumbers": [25,22],
			"Kind": "Mouse",
			"Pokedex": "It stores electricity in the electric sacs on its cheeks. When it releases pent-up energy in a burst, the electric power is equal to a lightning bolt.",
			"WildItemCommon": "ORANBERRY",
			"WildItemRare": "LIGHTBALL",
			"BattlerPlayerY": 0,
			"BattlerEnemyY": 16,
			"BattlerAltitude": 0,
			"Evolutions": [
				{"InternalName": "RAICHU", "Method": "Item", "Item": "THUNDERSTONE"}
			]
		}
	}
	return pokedata[id]