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
	var ivs = {
		"hp": randi()%30 + 1,
		"attack": randi()%30 + 1,
		"defense": randi()%30 + 1,
		"special_attack": randi()%30 + 1,
		"special_defense": randi()%30 + 1,
		"speed": randi()%30 + 1
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
		"stats": stats
	}
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
	