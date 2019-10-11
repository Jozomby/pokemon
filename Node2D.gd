extends Node2D
signal map_transition
var Utils = preload("utils.gd")
var AttackData = preload("attack_data.gd")

export var active_pokemon = {}
export var opposing_pokemon = {}

export var return_map = "Route1"
export var return_position = Vector2(0,0)

var location = "Field"
var base_active_hp_bar_position
var base_opposing_hp_bar_position
var base_experience_bar_position
var battle_interface
var battle_message
var messages = []
var attacks = []
var finished = false
var actions_taken = 0

func _ready():
	battle_interface = $BattleInterface
	battle_message = $BattleMessage
	remove_child(battle_interface)
	active_pokemon = Utils.generatePokemon({"id": 1, "level": 8})
	active_pokemon["current_hp"] = active_pokemon["stats"]["hp"]
	active_pokemon["max_hp"] = active_pokemon["stats"]["hp"]
	active_pokemon["stat_mods"] = {"attack": 0, "defense": 0, "special_attack": 0, "special_defense": 0, "speed": 0, "accuracy": 0}
	active_pokemon["attacks"] = Utils.fillOutAttacks(active_pokemon["attacks"])
	active_pokemon["experience_since_last_level"] = 2
	active_pokemon["experience"] = active_pokemon["experience"] + active_pokemon["experience_since_last_level"]
	active_pokemon["experience_needed"] = Utils.calculateExperience(active_pokemon["growth_rate"], active_pokemon["level"]+1) - active_pokemon["experience"]
	active_pokemon["status"] = ""
	active_pokemon["temp_status"] = ""
	battle_interface.active_pokemon = active_pokemon
	battle_interface.connect("attack_chosen", self, "handle_attack_chosen")
	battle_message.connect("message_acknowledged", self, "handle_message_acknowledged")
	if !opposing_pokemon.has("id"):
		opposing_pokemon = Utils.generatePokemon({"id": 25, "level": 4})
	opposing_pokemon["current_hp"] = opposing_pokemon["stats"]["hp"]
	opposing_pokemon["max_hp"] = opposing_pokemon["stats"]["hp"]
	opposing_pokemon["attacks"] = Utils.fillOutAttacks(opposing_pokemon["attacks"])
	opposing_pokemon["stat_mods"] = {"attack": 0, "defense": 0, "special_attack": 0, "special_defense": 0, "speed": 0, "accuracy": 0}
	opposing_pokemon["status"] = ""
	opposing_pokemon["temp_status"] = []
	messages.append("A wild " + opposing_pokemon["name"] + " appeared!")
	base_active_hp_bar_position = $CanvasLayer/ActiveHpBar.position
	base_opposing_hp_bar_position = $CanvasLayer/OpposingHpBar.position
	base_experience_bar_position = $CanvasLayer/ExperienceBar.position
	battler()

func _draw():
	var background_sprite = Sprite.new()
	var background_texture = load("res://essentials-master/Graphics/Battlebacks/battlebg" + location + ".png")
	var active_base_sprite = Sprite.new()
	var active_base_texture = load("res://essentials-master/Graphics/Battlebacks/playerbase" + location + ".png")
	var opposing_base_sprite = Sprite.new()
	var opposing_base_texture = load("res://essentials-master/Graphics/Battlebacks/enemybase" + location + ".png")
	var active_sprite = Sprite.new()
	var active_texture = load("res://essentials-master/Graphics/Battlers/" + str(active_pokemon["id"]).pad_zeros(3) + ("s" if active_pokemon["shiny"] else "") + "b.png")
	var opposing_sprite = Sprite.new()
	var opposing_texture = load("res://essentials-master/Graphics/Battlers/" + str(opposing_pokemon["id"]).pad_zeros(3) + ("s" if opposing_pokemon["shiny"] else "") + ".png")
	background_sprite.texture = background_texture
	background_sprite.position = Vector2(256, 144)
	active_base_sprite.texture = active_base_texture;
	active_base_sprite.position = Vector2(80, 256);
	opposing_base_sprite.texture = opposing_base_texture;
	opposing_base_sprite.position = Vector2(400, 115);
	active_sprite.texture = active_texture;
	active_sprite.position = Vector2(80, 208)
	opposing_sprite.texture = opposing_texture;
	opposing_sprite.position = Vector2(400, 95)
	add_child(background_sprite)
	add_child(active_base_sprite)
	add_child(opposing_base_sprite)
	add_child(active_sprite)
	add_child(opposing_sprite)
	$CanvasLayer/ActiveName.text = active_pokemon["name"]
	$CanvasLayer/OpposingName.text = opposing_pokemon["name"]
	$CanvasLayer/ActiveLevel.text = str(active_pokemon["level"])
	$CanvasLayer/OpposingLevel.text = str(opposing_pokemon["level"])
	$CanvasLayer/MaxHp.text = str(active_pokemon["max_hp"])

func battler():
	if messages.size() > 0:
		remove_child(battle_interface)
		battle_message.text = messages[0]
		messages.remove(0)
		add_child(battle_message)
	elif finished:
		remove_child(battle_message)
		emit_signal("map_transition", return_map, return_position)
	elif opposing_pokemon["current_hp"] == 0:
		gain_experience(active_pokemon, opposing_pokemon)
		battler()
	elif active_pokemon["current_hp"] == 0:
		messages.append("You're out of usable pokemon!")
		messages.append("You whited out.")
		finished = true
		battler()
	elif actions_taken == 2:
		process_end_turn()
	else:
		remove_child(battle_message)
		add_child(battle_interface)
		if attacks.size() > 0:
			var attack = attacks[0]
			attacks.remove(0)
			make_attack(attack["attacker"], attack["target"], attack["attack"])

func _process(delta):
	$CanvasLayer/CurrentHp.text = str(active_pokemon["current_hp"])
	var active_percent_hp = float(active_pokemon["current_hp"]) / active_pokemon["max_hp"]
	var active_hp_frame = 0 if active_percent_hp > 0.5 else (1 if active_percent_hp > 0.2 else 2)
	var active_pixel_offset = (96-(active_percent_hp * 96))/2
	$CanvasLayer/ActiveHpBar.frame = active_hp_frame
	$CanvasLayer/ActiveHpBar.scale = Vector2(active_percent_hp, 1)
	$CanvasLayer/ActiveHpBar.position = Vector2(base_active_hp_bar_position.x - active_pixel_offset, base_active_hp_bar_position.y)

	var opposing_percent_hp = float(opposing_pokemon["current_hp"]) / opposing_pokemon["max_hp"]
	var opposing_hp_frame = 0 if opposing_percent_hp > 0.5 else (1 if opposing_percent_hp > 0.2 else 2)
	var opposing_pixel_offset = (96-(opposing_percent_hp * 96))/2
	$CanvasLayer/OpposingHpBar.frame = opposing_hp_frame
	$CanvasLayer/OpposingHpBar.scale = Vector2(opposing_percent_hp, 1)
	$CanvasLayer/OpposingHpBar.position = Vector2(base_opposing_hp_bar_position.x - opposing_pixel_offset, base_opposing_hp_bar_position.y)
	
	var percent_experience = float(active_pokemon["experience_since_last_level"]) / active_pokemon["experience_needed"]
	var experience_pixel_offset = (192-(percent_experience * 192))/2
	$CanvasLayer/ExperienceBar.scale = Vector2(percent_experience, 1)
	$CanvasLayer/ExperienceBar.position = Vector2(base_experience_bar_position.x - experience_pixel_offset, base_experience_bar_position.y)

func handle_message_acknowledged():
	battler()

func handle_attack_chosen(attack_index):
	var active_attack = active_pokemon["attacks"][attack_index]
	var opposing_attack_index = randi()%opposing_pokemon["attacks"].size()
	var opposing_attack = opposing_pokemon["attacks"][opposing_attack_index]
	var going_first = "active" if active_pokemon["stats"]["speed"] * Utils.statModToMultiplier(active_pokemon["stat_mods"]["speed"]) > opposing_pokemon["stats"]["speed"] * Utils.statModToMultiplier(opposing_pokemon["stat_mods"]["speed"]) else ( "opposing" if opposing_pokemon["stats"]["speed"] * Utils.statModToMultiplier(opposing_pokemon["stat_mods"]["speed"]) > active_pokemon["stats"]["speed"] * Utils.statModToMultiplier(active_pokemon["stat_mods"]["speed"]) else ("active" if randi()%2 == 0 else "opposing"))
	attacks.append({
		"attacker": active_pokemon if going_first == "active" else opposing_pokemon,
		"target": opposing_pokemon if going_first == "active" else active_pokemon,
		"attack": active_attack if going_first == "active" else opposing_attack
	})
	attacks.append({
		"attacker": opposing_pokemon if going_first == "active" else active_pokemon,
		"target": active_pokemon if going_first == "active" else opposing_pokemon,
		"attack": opposing_attack if going_first == "active" else active_attack
	})
	battler()

func process_end_turn():
	if active_pokemon["temp_status"].find("SEEDED") >= 0:
		messages.append(active_pokemon["name"] + "'s health was sapped by LEECH SEED!")
		do_leech_seed(opposing_pokemon, active_pokemon)
	elif opposing_pokemon["temp_status"].find("SEEDED") >= 0:
		messages.append(opposing_pokemon["name"] + "'s health was sapped by LEECH SEED!")
		do_leech_seed(active_pokemon, opposing_pokemon)
	actions_taken = 0
	battler()

func do_leech_seed(attacker, target):
	var amount = target["max_hp"] / 8
	target["current_hp"] = target["current_hp"] - amount
	attacker["current_hp"] = attacker["current_hp"] + amount
	if attacker["current_hp"] > attacker["max_hp"]:
		attacker["current_hp"] = attacker["max_hp"]

func gain_experience(receiver, provider):
	var is_wild = true
	var traded = false
	var lucky_egg = false
	var exp_share_modifier = 1
	var experience = ((1 if is_wild else 1.5) * (1.5 if traded else 1) * provider["base_exp"] * (1.5 if lucky_egg else 1) * provider["level"]) / (7 * exp_share_modifier)
	messages.append(receiver["name"] + " gained " + str(experience) + " exp!")
	receiver["experience"] = receiver["experience"] + experience
	receiver["experience_since_last_level"] = receiver["experience_since_last_level"] + experience
	if receiver["experience_since_last_level"] >= receiver["experience_needed"]:
		var overflowed_experience = abs(float(receiver["experience_needed"]))
		receiver["experience_since_last_level"] = overflowed_experience
		receiver["experience_needed"] = Utils.calculateExperience(receiver["growth_rate"], receiver["level"] + 2)
		level_up(receiver)
	finished = true

func level_up(pokemon):
	#TODO: update stats
	messages.append(pokemon["name"] + " grew to level " + str(pokemon["level"] + 1) + "!")
	pokemon["level"] = pokemon["level"] + 1
	update()

func make_attack(attacker, target, attack):
	#TODO: implement PP
	messages.append(attacker["name"] + " used " + attack["name"] + ".")
	var accuracy_check = randi()%100
	var accuracy_threshold = attack["accuracy"] * Utils.accuracyModToMultiplier(attacker["stat_mods"]["accuracy"])
	if accuracy_check > accuracy_threshold:
		messages.append("The attack missed.")
	else:
		if attack["power"] > 0:
			do_damage(attacker, target, attack)
		if attack["effects"].size() > 0:
			for effect in attack["effects"]:
				do_effect(attacker, target, effect)
	actions_taken += 1
	battler()

func do_effect(attacker, target, effect):
	var status_target = target if effect["target"] == "opponent" else attacker
	if effect["type"] == "STAT":
		var too_high = false
		var too_low = false
		var status_change = effect["num_stages"] if effect["direction"] == "up" else -1 * effect["num_stages"]
		if effect["stat"] == "attack":
			var new_stat_mod = status_target["stat_mods"]["attack"] + status_change
			if new_stat_mod > 6:
				too_high = true
			elif new_stat_mod < -6:
				too_low = true
			else:
				status_target["stat_mods"]["attack"] = new_stat_mod
		elif effect["stat"] == "defense":
			var new_stat_mod = status_target["stat_mods"]["defense"] + status_change
			if new_stat_mod > 6:
				too_high = true
			elif new_stat_mod < -6:
				too_low = true
			else:
				status_target["stat_mods"]["defense"] = new_stat_mod
		elif effect["stat"] == "special_attack":
			var new_stat_mod = status_target["stat_mods"]["special_attack"] + status_change
			if new_stat_mod > 6:
				too_high = true
			elif new_stat_mod < -6:
				too_low = true
			else:
				status_target["stat_mods"]["special_attack"] = new_stat_mod
		elif effect["stat"] == "special_defense":
			var new_stat_mod = status_target["stat_mods"]["special_defense"] + status_change
			if new_stat_mod > 6:
				too_high = true
			elif new_stat_mod < -6:
				too_low = true
			else:
				status_target["stat_mods"]["special_defense"] = new_stat_mod
		elif effect["stat"] == "speed":
			var new_stat_mod = status_target["stat_mods"]["speed"] + status_change
			if new_stat_mod > 6:
				too_high = true
			elif new_stat_mod < -6:
				too_low = true
			else:
				status_target["stat_mods"]["speed"] = new_stat_mod
		elif effect["stat"] == "accuracy":
			var new_stat_mod = status_target["stat_mods"]["accuracy"] + status_change
			if new_stat_mod > 6:
				too_high = true
			elif new_stat_mod < -6:
				too_low = true
			else:
				status_target["stat_mods"]["accuracy"] = new_stat_mod
		var change_direction_message = "increased" if effect["direction"] == "up" else "decreased"
		var change_amount_message = "" if effect["num_stages"] == 1 else (" greatly" if effect["num_stages"] == 2 else " drastically")
		if too_high:
			messages.append(status_target["name"] + "'s " + effect["stat"] + " can't go any higher.")
		elif too_low:
			messages.append(status_target["name"] + "'s " + effect["stat"] + " can't go any lower.")
		else:
			messages.append(status_target["name"] + "'s " + effect["stat"] + " " + change_direction_message + change_amount_message + ".")
	elif effect["type"] == "STATUS":
		#TODO: Implement Status
		var status_chance_rand = randi()%100
		if status_chance_rand < effect["rate"]:
			messages.append(target["name"] + " was inflicted with " + effect["status"] + ".")
			target["status"] = effect["status"]
			print("Status effects not yet implemented")
	elif effect["type"] == "SEEDED":
		if target["type1"] == "GRASS" || (target.has("type2") && target["type2"] == "GRASS"):
			messages.append("There was no effect!")
		elif target["temp_status"].find("SEEDED") < 0:
			target["temp_status"].append("SEEDED")
			messages.append(target["name"] + " was seeded!")
		else:
			messages.append(target["name"] + " is already seeded.")

func do_damage(attacker, target, attack):
	var attack_stat = attacker["stats"]["attack"] * Utils.statModToMultiplier(attacker["stat_mods"]["attack"]) if attack["kind"] == "Physical" else attacker["stats"]["special_attack"] * Utils.statModToMultiplier(attacker["stat_mods"]["special_attack"])
	var defense_stat = target["stats"]["defense"] * Utils.statModToMultiplier(target["stat_mods"]["defense"]) if attack["kind"] == "Physical" else target["stats"]["special_defense"] * Utils.statModToMultiplier(target["stat_mods"]["special_defense"])
	var attacking_types = []
	var defending_types = []
	var stab = 1
	if (attacker.has("type1") && attacker["type1"] == attack["type"]) || (attacker.has("type1") && attack.has("type2") && attacker["type1"] == attack["type2"]):
		stab = 1.5
	if (attacker.has("type2") && attacker["type2"] == attack["type"]) || (attacker.has("type1") && attack.has("type2") && attacker["type2"] == attack["type2"]):
		stab = 1.5
	attacking_types.append(attack["type"])
	if attack.has("type2"):
		attacking_types.append(attack["type2"])
	if target.has("type1"):
		defending_types.append(target["type1"])
	if target.has("type2"):
		defending_types.append(target["type2"])
	var type_modifier = Utils.getTypeEffectiveness(attacking_types, defending_types)
	if type_modifier == 0:
		messages.append("It had no effect...")
	elif type_modifier < 1:
		messages.append("It wasn't very effective.")
	elif type_modifier > 1:
		messages.append("It was super effective!")
	var critical_chance = randi()%16
	var critical = 2 if critical_chance == 13 else 1
	#randomize()
	var random = float(randi()%16 + 85)/100
	var damage = floor(((((((2 * attacker["level"]) / 5) + 2) * attack["power"] * (attack_stat / defense_stat)) / 50) + 2) * (type_modifier * critical * random * stab))
	if damage < 1:
		damage = 1
	var new_hp = target["current_hp"] - damage
	target["current_hp"] = new_hp if new_hp >= 0 else 0
	if target["current_hp"] == 0:
		messages.append(target["name"] + " fainted.")