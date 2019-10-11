extends Node2D
signal message_acknowledged

var text = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("write_text")

func write_text():
	$MessageText.text = text

func _process(delta):
	if $MessageText.text != text:
		$MessageText.text = text
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("message_acknowledged")
	