extends Node2D

var active_pokemon = {
	"id": 1,
	"name": "Bulbasaur",
	"max_hp": 32,
	"current_hp": 30,
	"level": 8,
	"experience_needed": 120,
	"experience": 64,
	"shiny": true
}
var opposing_pokemon = {
	"id": 16,
	"name": "Pidgey",
	"max_hp": 16,
	"current_hp": 16,
	"level": 4,
	"shiny": false
}

var location = "Field"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var background_sprite = Sprite.new()
	var background_texture = load("res://essentials-master/Graphics/Battlebacks/battlebg" + location + ".png")
	var active_base_sprite = Sprite.new()
	var active_base_texture = load("res://essentials-master/Graphics/Battlebacks/playerbase" + location + ".png")
	var opposing_base_sprite = Sprite.new()
	var opposing_base_texture = load("res://essentials-master/Graphics/Battlebacks/enemybase" + location + ".png")
	var active_sprite = Sprite.new()
	var active_texture = load("res://essentials-master/Graphics/Battlers/" + str(active_pokemon["id"]).pad_zeros(3) + ("s" if active_pokemon["shiny"] else "") + "b.png")
	var opposing_sprite = Sprite.new()
	var opposing_texture = load("res://essentials-master/Graphics/Battlers/" + str(opposing_pokemon["id"]).pad_zeros(3) + ("s" if opposing_pokemon["shiny"] else "") + ".png")
	background_sprite.texture = background_texture
	background_sprite.position = Vector2(256, 144)
	active_base_sprite.texture = active_base_texture;
	active_base_sprite.position = Vector2(80, 256);
	opposing_base_sprite.texture = opposing_base_texture;
	opposing_base_sprite.position = Vector2(400, 115);
	active_sprite.texture = active_texture;
	active_sprite.position = Vector2(80, 208)
	opposing_sprite.texture = opposing_texture;
	opposing_sprite.position = Vector2(400, 95)
	add_child(background_sprite)
	add_child(active_base_sprite)
	add_child(opposing_base_sprite)
	add_child(active_sprite)
	add_child(opposing_sprite)
	$CanvasLayer/ActiveName.text = active_pokemon["name"]
	$CanvasLayer/OpposingName.text = opposing_pokemon["name"]
	$CanvasLayer/ActiveLevel.text = str(active_pokemon["level"])
	$CanvasLayer/OpposingLevel.text = str(opposing_pokemon["level"])
