extends Node2D
signal encounter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		#randomize()
		var encounter_roll = randi()%100
		# Encounter rate is temporarily set to 15 rather than 7 for testing purposes
		if encounter_roll < 15:
			emit_signal("encounter")
