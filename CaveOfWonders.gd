extends Node2D
signal map_transition

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.enable_light()
	for child in get_children():
		if child.is_in_group("encounter"):
			child.connect("encounter", self, "handle_encounter")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Route1Entrance_body_entered(body):
	if (body.name == "Player"):
		emit_signal("map_transition", "Route1")
