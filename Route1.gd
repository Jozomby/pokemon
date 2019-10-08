extends Node2D
signal map_transition
signal begin_encounter

var Utils = preload("utils.gd")

var available_pokemon = [
	{
		"id": 10,
		"levels": [3, 4],
		"rand_max": 34
	},
	{
		"id": 16,
		"levels": [3, 4, 5],
		"rand_max": 84
	},
	{
		"id": 25,
		"levels": [5, 6],
		"rand_max": 100
	}
]

func _ready():
	print("IN READY FOR ROUTE 1")
	$Player.disable_light()
	for child in get_children():
		if child.is_in_group("encounter"):
			child.connect("encounter", self, "handle_encounter")

func _on_CaveOfWondersEntrance_body_entered(body):
	if (body.name == "Player"):
		emit_signal("map_transition", "CaveOfWonders")
		
func handle_encounter():
	print("IN HANDLE ENCOUNTER")
	var pokemon = Utils.generateEncounter(available_pokemon)
	emit_signal("begin_encounter", pokemon, "Route1")
