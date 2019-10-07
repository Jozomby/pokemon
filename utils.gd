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