extends Node2D
signal map_transition

export var player_position = Vector2(64, 480)

func _ready():
	$Player.enable_light()
	$Player.position = player_position
	for child in get_children():
		if child.is_in_group("encounter"):
			child.connect("encounter", self, "handle_encounter")

func _on_Route1Entrance_body_entered(body):
	if (body.name == "Player"):
		emit_signal("map_transition", "Route1", Vector2(480, 416))
