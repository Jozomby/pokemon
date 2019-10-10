extends CanvasLayer

var AttackData = preload("attack_data.gd")

var active_pokemon = { 
	"ability": "OVERGROW",
	"attacks": [
		{
			"accuracy": 100,
			"contact": true,
			"current_pp": 35,
			"description": "A physical attack in which the user charges and slams into the target with its whole body.",
			"disabled": false,
			"effects": [],
			"id": 303,
			"internal_name": "TACKLE",
			"kind": "Physical",
			"max_pp": 35,
			"name": "Tackle",
			"power": 50,
			"pp": 35,
			"target": "SINGLE_ADJACENT",
			"type": "NORMAL"
		},
		{
			"accuracy": 100,
			"contact": false,
			"current_pp": 40,
			"description": "The user growls in an endearing way, making the foe less wary. The foe's Attack stat is lowered.",
			"disabled": false,
			"effects": [
				{
					"direction": "down",
					"num_stages": 1,
					"stat": "attack",
					"type": "STAT"
				}
			],
			"id": 368,
			"internal_name": "GROWL",
			"kind": "Status",
			"max_pp": 40,
			"name": "Growl",
			"power": 0,
			"pp": 40,
			"target": "ALL_ADJACENT_FOES",
			"type": "NORMAL"
		},
		{
			"accuracy": 90,
			"contact": false,
			"current_pp": 10,
			"description": "A seed is planted on the target. It steals some HP from the target every turn.",
			"disabled": false,
			"effects": [
				{
					"type": "SEEDED"
				}
			],
			"id": 217,
			"internal_name": "LEECHSEED",
			"kind": "Status",
			"max_pp": 10,
			"name": "Leech Seed",
			"power": 0,
			"pp": 10,
			"target": "SINGLE_ADJACENT",
			"type": "GRASS"
		}
	],
	"current_hp": 25,
	"evs": { "attack":0, "defense":0, "hp":0, "special_attack":0, "special_defense":0, "speed":0},
	"experience_needed":96,
	"experience_since_last_level":24,
	"gender":"male",
	"id":1,
	"ivs":{"attack":31, "defense":23, "hp":5, "special_attack":15, "special_defense":16, "speed":8},
	"level":8,
	"max_hp":25,
	"name":"Bulbasaur",
	"nature":{"down":"attack", "name":"Modest", "up":"special_attack"},
	"shiny":false,
	"stats":{"attack":18, "defense":15, "hp":25, "special_attack":17, "special_defense":16, "speed":16}
}
var selected_attack = 0
var attack_type_overlays = []
var attack_labels = []

func _ready():
	call_deferred("populate_attacks")
	call_deferred("draw_attacks")

func _process(delta):
	var new_selected_attack = selected_attack
	if Input.is_action_pressed("ui_accept"):
		pass
	elif Input.is_action_pressed("ui_down"):
		if selected_attack == 0:
			new_selected_attack = (2 if active_pokemon["attacks"].size() > 2 else 0)
		elif selected_attack == 1:
			new_selected_attack = (3 if active_pokemon["attacks"].size() > 3 else 1)
	elif Input.is_action_pressed("ui_up"):
		if selected_attack == 2:
			new_selected_attack = 0
		elif selected_attack == 3:
			new_selected_attack = 1
	elif Input.is_action_pressed("ui_right"):
		if selected_attack == 0:
			new_selected_attack = (1 if active_pokemon["attacks"].size() > 1 else 0)
		elif selected_attack == 2:
			new_selected_attack = (3 if active_pokemon["attacks"].size() > 3 else 2)
	elif Input.is_action_pressed("ui_left"):
		if selected_attack == 1:
			new_selected_attack = 0
		elif selected_attack == 3:
			new_selected_attack = 2
	if new_selected_attack != selected_attack:
		selected_attack = new_selected_attack
		draw_attacks()

func draw_attacks():
	var j = 0
	for overlay in attack_type_overlays:
		if j >= active_pokemon["attacks"].size():
			overlay.remove_and_skip()
			attack_labels[j].remove_and_skip()
		else:
			attack_labels[j].text = active_pokemon["attacks"][j]["name"]
		j += 1
	var i = 0
	for attack in active_pokemon["attacks"]:
		var type_index = AttackData.getTypeId(attack["type"])
		var selected = i == selected_attack
		attack_type_overlays[i].frame = type_index * 2 + 1 if selected else type_index * 2
		i += 1
	draw_selected_info()

func draw_selected_info():
	var type_index = AttackData.getTypeId(active_pokemon["attacks"][selected_attack]["type"])
	$SelectedType.frame = type_index
	$CurrentPP.text = str(active_pokemon["attacks"][selected_attack]["current_pp"])
	$MaxPP.text = str(active_pokemon["attacks"][selected_attack]["max_pp"])

func populate_attacks():
	attack_type_overlays = [
		$AttackTypeOverlay1,
		$AttackTypeOverlay2,
		$AttackTypeOverlay3,
		$AttackTypeOverlay4
	]
	attack_labels = [
		$AttackLabel1,
		$AttackLabel2,
		$AttackLabel3,
		$AttackLabel4
	]
