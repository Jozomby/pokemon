extends Node2D

var active_pokemon = {
	"id": 1,
	"shiny": true
}
var opposing_pokemon = {
	"id": 16,
	"shiny": false
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var active_sprite = Sprite.new()
	var active_texture = load("res://essentials-master/Graphics/Battlers/" + str(active_pokemon["id"]).pad_zeros(3) + ("s" if active_pokemon["shiny"] else "") + "b.png")
	var opposing_sprite = Sprite.new()
	var opposing_texture = load("res://essentials-master/Graphics/Battlers/" + str(opposing_pokemon["id"]).pad_zeros(3) + ("s" if opposing_pokemon["shiny"] else "") + ".png")
	active_sprite.texture = active_texture;
	active_sprite.position = $ActivePosition2D.position;
	opposing_sprite.texture = opposing_texture;
	opposing_sprite.position = $OpposingPosition2D.position
	add_child(active_sprite)
	add_child(opposing_sprite)
