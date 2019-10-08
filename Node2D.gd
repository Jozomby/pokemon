extends Node2D

var active_pokemon = {
	"id": 1,
	"shiny": true
}
var opposing_pokemon = {
	"id": 16,
	"shiny": false
}

var background = "Field"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var background_sprite = Sprite.new()
	var background_texture = load("res://essentials-master/Graphics/Battlebacks/battlebg" + background + ".png")
	var active_sprite = Sprite.new()
	var active_texture = load("res://essentials-master/Graphics/Battlers/" + str(active_pokemon["id"]).pad_zeros(3) + ("s" if active_pokemon["shiny"] else "") + "b.png")
	var opposing_sprite = Sprite.new()
	var opposing_texture = load("res://essentials-master/Graphics/Battlers/" + str(opposing_pokemon["id"]).pad_zeros(3) + ("s" if opposing_pokemon["shiny"] else "") + ".png")
	background_sprite.texture = background_texture
	background_sprite.position = Vector2(256, 144)
	active_sprite.texture = active_texture;
	active_sprite.position = Vector2(80, 175)
	opposing_sprite.texture = opposing_texture;
	opposing_sprite.position = Vector2(400, 95)
	add_child(background_sprite)
	add_child(active_sprite)
	add_child(opposing_sprite)
