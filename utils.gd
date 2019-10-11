static func generateEncounter(available_pokemon):
	randomize()
	var rand_poke_selector = randi()%100
	var poke_index = 0
	while available_pokemon[poke_index]["rand_max"] < rand_poke_selector:
		poke_index += 1
	var species = available_pokemon[poke_index]
	var rand_level_selector = randi()%(species["levels"].size())
	var level = species["levels"][rand_level_selector]
	var pokemon = {
		"id": species["id"],
		"level": level
	}
	return pokemon

static func generateShiny():
	var shiny_chance = randi()%8192
	if shiny_chance == 37:
		return true
	else:
		return false

static func generateNature():
	var NatureData = preload("nature_data.gd")
	var nature_id = randi()%25
	return NatureData.getNature(nature_id)
	
static func generatePokemonGender(gender_rate):
	if gender_rate == "Genderless":
		return "none"
	if gender_rate == "AlwaysFemale":
		return "female"
	if gender_rate == "AlwaysMale":
		return "male"
	var gender_rand = randi()%100
	if gender_rate == "Female50Percent":
		if gender_rand < 50:
			return "female"
		else:
			return "male"
	elif gender_rate == "Female25Percent":
		if gender_rand < 25:
			return "female"
		else:
			return "male"
	elif gender_rate == "Female75Percent":
		if gender_rand < 75:
			return "female"
		else:
			return "male"
	elif gender_rate == "FemaleOneEighth":
		if gender_rand < 13:
			return "female"
		else:
			return "male"
	
static func generateAbility(abilities):
	var ability_index = randi()%abilities.size()
	return abilities[ability_index]
	
static func generateAttacks(move_list, level):
	var available_moves = []
	for move in move_list:
		if move["Level"] <= level:
			available_moves.append(move["Move"])
	if available_moves.size() <= 4:
		return available_moves
	else:
		var recent_moves = []
		var last_index = available_moves.size() - 1
		recent_moves.append(available_moves[last_index])
		recent_moves.append(available_moves[last_index - 1])
		recent_moves.append(available_moves[last_index - 2])
		recent_moves.append(available_moves[last_index - 3])
		return recent_moves
		
static func generateHp(base_hp, level, hp_iv, hp_ev):
	if base_hp == 1:
		return 1
	return int(((((2*base_hp) + hp_iv + (hp_ev/4))*level)/100) + level + 10)
	
static func generateStat(base_stat, level, iv, ev, nature_modifier):
	return int((((((2*base_stat) + iv + (ev/4))*level)/100) + 5) * nature_modifier)
		
static func generateStats(base_stats, level, ivs, evs, nature):
	var attack_modifier = 1 + (0.1 if nature["up"] == "attack" else 0) - (0.1 if nature["down"] == "attack" else 0)
	var defense_modifier = 1 + (0.1 if nature["up"] == "defense" else 0) - (0.1 if nature["down"] == "defense" else 0)
	var special_attack_modifier = 1 + (0.1 if nature["up"] == "special_attack" else 0) - (0.1 if nature["down"] == "special_attack" else 0)
	var special_defense_modifier = 1 + (0.1 if nature["up"] == "special_defense" else 0) - (0.1 if nature["down"] == "special_defense" else 0)
	var speed_modifier = 1 + (0.1 if nature["up"] == "speed" else 0) - (0.1 if nature["down"] == "speed" else 0)
	return {
		"hp": generateHp(base_stats[0], level, ivs["hp"], evs["hp"]),
		"attack": generateStat(base_stats[1], level, ivs["attack"], evs["attack"], attack_modifier),
		"defense": generateStat(base_stats[2], level, ivs["defense"], evs["defense"], defense_modifier),
		"special_attack": generateStat(base_stats[3], level, ivs["special_attack"], evs["special_attack"], special_attack_modifier),
		"special_defense": generateStat(base_stats[4], level, ivs["special_defense"], evs["special_defense"], special_defense_modifier),
		"speed": generateStat(base_stats[5], level, ivs["speed"], evs["speed"], speed_modifier),
	}
	
static func calculateExperience(growth_rate, level):
	if growth_rate == "Parabolic":
		return floor(((float(6)/5)*level*level*level) - (15*level*level) + (100 * level) - 140)
	elif growth_rate == "Medium":
		return floor(level*level*level)
	elif growth_rate == "Fast":
		return floor(float(4*level*level*level) / 5)
	elif growth_rate == "Slow":
		return floor(float(5*level*level*level)/4)
	elif growth_rate == "Erratic":
		if level <= 50:
			return floor(float((level*level*level)*(100-level))/50)
		elif level <= 68:
			return floor(float((level*level*level)*(150-level))/100)
		elif level <= 98:
			return floor(((level*level*level)*(float(1911-(10*level))/3))/500)
		else:
			return floor(float((level*level*level)*(160-level))/100)
	elif growth_rate == "Fluctuating":
		if level <= 15:
			return floor((level*level*level)*(((float(level+1)/3)+24)/50))
		elif level <= 36:
			return floor((level*level*level)*(float(level+14)/50))
		else:
			return floor((level*level*level)*(float((level/2)+32)/50))

static func generatePokemon(pokemon):
	var PokemonData = preload("pokemon_data.gd")
	var pokedata = PokemonData.getPokemon(pokemon["id"])
	var shiny = generateShiny()
	var id = pokemon["id"]
	var level = pokemon["level"]
	var name = pokedata["Name"]
	var gender = generatePokemonGender(pokedata["GenderRate"])
	var nature = generateNature()
	var ability = generateAbility(pokedata["Abilities"])
	var attacks = pokemon["attacks"] if pokemon.has("attacks") else generateAttacks(pokedata["Moves"], level)
	var experience = calculateExperience(pokedata["GrowthRate"], level)
	var ivs = {
		"hp": randi()%31 + 1,
		"attack": randi()%31 + 1,
		"defense": randi()%31 + 1,
		"special_attack": randi()%31 + 1,
		"special_defense": randi()%31 + 1,
		"speed": randi()%31 + 1
	}
	var evs = {
		"hp": 0,
		"attack": 0,
		"defense": 0,
		"special_attack": 0,
		"special_defense": 0,
		"speed": 0
	}
	var stats = generateStats(pokedata["BaseStats"], level, ivs, evs, nature)
	var generatedPokemon = {
		"id": id,
		"shiny": shiny,
		"level": level,
		"name": name,
		"gender": gender,
		"nature": nature,
		"ability": ability,
		"attacks": attacks,
		"ivs": ivs,
		"evs": evs,
		"stats": stats,
		"growth_rate": pokedata["GrowthRate"],
		"base_exp": pokedata["BaseEXP"],
		"experience": experience,
		"effort_points": pokedata["EffortPoints"],
		"base_stats": pokedata["BaseStats"]
	}
	if pokedata.has("Type1"):
		generatedPokemon["type1"] = pokedata["Type1"]
	if pokedata.has("Type2"):
		generatedPokemon["type2"] = pokedata["Type2"]
	return generatedPokemon
	
static func fillOutAttacks(attack_names):
	var AttackData = preload("attack_data.gd")
	var attacks = []
	for attack in attack_names:
		var filled_out_attack = AttackData.getAttack(attack)
		filled_out_attack["disabled"] = false
		filled_out_attack["max_pp"] = filled_out_attack["pp"]
		filled_out_attack["current_pp"] = filled_out_attack["pp"]
		attacks.append(filled_out_attack)
	return attacks
	
static func getTypeEffectiveness(attacking_types, defending_types):
	var matchup1 = getTypeMatchup(attacking_types[0], defending_types[0])
	var matchup2 = getTypeMatchup(attacking_types[0], defending_types[1]) if defending_types.size() > 1 else 1
	var matchup3 = getTypeMatchup(attacking_types[1], defending_types[0]) if attacking_types.size() > 1 else 1
	var matchup4 = getTypeMatchup(attacking_types[1], defending_types[1]) if (attacking_types.size() > 1 && defending_types.size() > 1) else 1
	return matchup1 * matchup2 * matchup3 * matchup4

static func statModToMultiplier(stat_mod):
	if stat_mod == -6:
		return 2/8
	elif stat_mod == -5:
		return 2/7
	elif stat_mod == -4:
		return 2/6
	elif stat_mod == -3:
		return 2/5
	elif stat_mod == -2:
		return 2/4
	elif stat_mod == -1:
		return 2/3
	elif stat_mod == 0:
		return 2/2
	elif stat_mod == 1:
		return 3/2
	elif stat_mod == 2:
		return 4/2
	elif stat_mod == 3:
		return 5/2
	elif stat_mod == 4:
		return 6/2
	elif stat_mod == 5:
		return 7/2
	elif stat_mod == 6:
		return 8/2

static func accuracyModToMultiplier(mod):
	var denom = float(100)
	if mod == -6:
		return 33/denom
	elif mod == -5:
		return 36/denom
	elif mod == -4:
		return 43/denom
	elif mod == -3:
		return 50/denom
	elif mod == -2:
		return 60/denom
	elif mod == -1:
		return 75/denom
	elif mod == 0:
		return 100/denom
	elif mod == 1:
		return 133/denom
	elif mod == 2:
		return 166/denom
	elif mod == 3:
		return 200/denom
	elif mod == 4:
		return 233/denom
	elif mod == 5:
		return 266/denom
	elif mod == 6:
		return 300/denom

static func getTypeMatchup(attacking_type, defending_type):
	if attacking_type == "NORMAL":
		if defending_type == "ROCK":
			return 0.5
		elif defending_type == "GHOST":
			return 0
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "FIRE":
		if defending_type == "FIRE":
			return 0.5
		elif defending_type == "WATER":
			return 0.5
		elif defending_type == "GRASS":
			return 2
		elif defending_type == "ICE":
			return 2
		elif defending_type == "BUG":
			return 2
		elif defending_type == "ROCK":
			return 0.5
		elif defending_type == "DRAGON":
			return 0.5
		elif defending_type == "STEEL":
			return 2
		else:
			return 1
	elif attacking_type == "WATER":
		if defending_type == "FIRE":
			return 2
		elif defending_type == "WATER":
			return 0.5
		elif defending_type == "GRASS":
			return 0.5
		elif defending_type == "GROUND":
			return 2
		elif defending_type == "ROCK":
			return 2
		elif defending_type == "DRAGON":
			return 0.5
		else:
			return 1
	elif attacking_type == "ELECTRIC":
		if defending_type == "WATER":
			return 2
		elif defending_type == "ELECTRIC":
			return 0.5
		elif defending_type == "GRASS":
			return 0.5
		elif defending_type == "GROUND":
			return 0
		elif defending_type == "FLYING":
			return 2
		elif defending_type == "DRAGON":
			return 0.5
		else:
			return 1
	elif attacking_type == "GRASS":
		if defending_type == "FIRE":
			return 0.5
		elif defending_type == "WATER":
			return 2
		elif defending_type == "GRASS":
			return 0.5
		elif defending_type == "POISON":
			return 0.5
		elif defending_type == "GROUND":
			return 2
		elif defending_type == "FLYING":
			return 0.5
		elif defending_type == "BUG":
			return 0.5
		elif defending_type == "ROCK":
			return 2
		elif defending_type == "DRAGON":
			return 0.5
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "ICE":
		if defending_type == "FIRE":
			return 0.5
		elif defending_type == "WATER":
			return 0.5
		elif defending_type == "GRASS":
			return 2
		elif defending_type == "ICE":
			return 0.5
		elif defending_type == "GROUND":
			return 2
		elif defending_type == "FLYING":
			return 2
		elif defending_type == "DRAGON":
			return 2
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "FIGHTING":
		if defending_type == "NORMAL":
			return 2
		elif defending_type == "ICE":
			return 2
		elif defending_type == "POISON":
			return 0.5
		elif defending_type == "FLYING":
			return 0.5
		elif defending_type == "PSYCHIC":
			return 0.5
		elif defending_type == "BUG":
			return 0.5
		elif defending_type == "ROCK":
			return 2
		elif defending_type == "GHOST":
			return 0
		elif defending_type == "DARK":
			return 2
		elif defending_type == "STEEL":
			return 2
		else:
			return 1
	elif attacking_type == "POISON":
		if defending_type == "GRASS":
			return 2
		elif defending_type == "POISON":
			return 0.5
		elif defending_type == "GROUND":
			return 0.5
		elif defending_type == "ROCK":
			return 0.5
		elif defending_type == "GHOST":
			return 0.5
		elif defending_type == "STEEL":
			return 0
		else:
			return 1
	elif attacking_type == "GROUND":
		if defending_type == "FIRE":
			return 2
		elif defending_type == "ELECTRIC":
			return 2
		elif defending_type == "GRASS":
			return 0.5
		elif defending_type == "POISON":
			return 2
		elif defending_type == "FLYING":
			return 0
		elif defending_type == "BUG":
			return 0.5
		elif defending_type == "ROCK":
			return 2
		elif defending_type == "STEEL":
			return 2
		else:
			return 1
	elif attacking_type == "FLYING":
		if defending_type == "ELECTRIC":
			return 0.5
		elif defending_type == "GRASS":
			return 2
		elif defending_type == "FIGHTING":
			return 2
		elif defending_type == "BUG":
			return 2
		elif defending_type == "ROCK":
			return 0.5
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "PSYCHIC":
		if defending_type == "FIGHTING":
			return 2
		elif defending_type == "POISON":
			return 2
		elif defending_type == "PSYCHIC":
			return 0.5
		elif defending_type == "DARK":
			return 0
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "BUG":
		if defending_type == "FIRE":
			return 0.5
		elif defending_type == "GRASS":
			return 2
		elif defending_type == "FIGHTING":
			return 0.5
		elif defending_type == "POSION":
			return 0.5
		elif defending_type == "FLYING":
			return 0.5
		elif defending_type == "PSYCHIC":
			return 2
		elif defending_type == "GHOST":
			return 0.5
		elif defending_type == "DARK":
			return 2
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "ROCK":
		if defending_type == "FIRE":
			return 2
		elif defending_type == "ICE":
			return 2
		elif defending_type == "FIGHTING":
			return 0.5
		elif defending_type == "GROUND":
			return 0.5
		elif defending_type == "FLYING":
			return 2
		elif defending_type == "BUG":
			return 2
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "GHOST":
		if defending_type == "NORMAL":
			return 0
		elif defending_type == "PSYCHIC":
			return 2
		elif defending_type == "GHOST":
			return 2
		elif defending_type == "DARK":
			return 0.5
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "DRAGON":
		if defending_type == "DRAGON":
			return 2
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "DARK":
		if defending_type == "FIGHTING":
			return 0.5
		elif defending_type == "PSYCHIC":
			return 2
		elif defending_type == "GHOST":
			return 2
		elif defending_type == "DARK":
			return 0.5
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	elif attacking_type == "STEEL":
		if defending_type == "FIRE":
			return 0.5
		elif defending_type == "WATER":
			return 0.5
		elif defending_type == "ELECTRIC":
			return 0.5
		elif defending_type == "ICE":
			return 2
		elif defending_type == "ROCK":
			return 2
		elif defending_type == "STEEL":
			return 0.5
		else:
			return 1
	else:
		print("UNKNOWN TYPE")
		print(attacking_type)
		print(defending_type)
		return 1