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

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child.is_in_group("encounter"):
			child.connect("encounter", self, "handle_encounter")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CaveOfWondersEntrance_body_entered(body):
	if (body.name == "Player"):
		emit_signal("map_transition", "CaveOfWonders")
		
func handle_encounter():
	var pokemon = Utils.generateEncounter(available_pokemon)
	emit_signal("begin_encounter", pokemon, "Route1")
