extends Node2D
signal map_transition
signal begin_encounter	

export var player_position = Vector2(416, 416)


func _ready():
	$NPC/Sprite.texture = (preload("res://essentials-master/Graphics/Characters/trchar071.png"))
	$NPC.message = "Wasssap! That's what all the cool kids say these days."

func _on_CaveOfWondersEntrance_body_entered(body):
	if (body.name == "Player"):
		emit_signal("map_transition", "CaveOfWonders", Vector2(64, 480))

