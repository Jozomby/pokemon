extends Node2D
signal map_transition

export var active_pokemon = {
	"id": 1,
	"name": "Bulbasaur",
	"gender": "male",
	"max_hp": 32,
	"current_hp": 29,
	"level": 8,
	"experience_needed": 120,
	"experience_since_last_level": 90,
	"shiny": true
}
export var opposing_pokemon = {
	"id": 16,
	"name": "Pidgey",
	"gender": "female",
	"max_hp": 16,
	"current_hp": 16,
	"level": 4,
	"shiny": false
}

export var return_map = "Route1"
export var return_pos = Vector2(0,0)

var location = "Field"
var base_active_hp_bar_position
var base_opposing_hp_bar_position
var base_experience_bar_position

# Called when the node enters the scene tree for the first time.
func _ready():
	base_active_hp_bar_position = $CanvasLayer/ActiveHpBar.position
	base_opposing_hp_bar_position = $CanvasLayer/OpposingHpBar.position
	base_experience_bar_position = $CanvasLayer/ExperienceBar.position

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
	$CanvasLayer/MaxHp.text = str(active_pokemon["max_hp"])

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("map_transition", return_map)

func _process(delta):
	$CanvasLayer/CurrentHp.text = str(active_pokemon["current_hp"])
	var active_percent_hp = float(active_pokemon["current_hp"]) / active_pokemon["max_hp"]
	var active_hp_frame = 0 if active_percent_hp > 0.5 else (1 if active_percent_hp > 0.2 else 2)
	var active_pixel_offset = (96-(active_percent_hp * 96))/2
	$CanvasLayer/ActiveHpBar.frame = active_hp_frame
	$CanvasLayer/ActiveHpBar.scale = Vector2(active_percent_hp, 1)
	$CanvasLayer/ActiveHpBar.position = Vector2(base_active_hp_bar_position.x - active_pixel_offset, base_active_hp_bar_position.y)

	var opposing_percent_hp = float(opposing_pokemon["current_hp"]) / opposing_pokemon["max_hp"]
	var opposing_hp_frame = 0 if opposing_percent_hp > 0.5 else (1 if opposing_percent_hp > 0.2 else 2)
	var opposing_pixel_offset = (96-(opposing_percent_hp * 96))/2
	$CanvasLayer/OpposingHpBar.frame = opposing_hp_frame
	$CanvasLayer/OpposingHpBar.scale = Vector2(opposing_percent_hp, 1)
	$CanvasLayer/OpposingHpBar.position = Vector2(base_opposing_hp_bar_position.x - opposing_pixel_offset, base_opposing_hp_bar_position.y)
	
	var percent_experience = float(active_pokemon["experience_since_last_level"]) / active_pokemon["experience_needed"]
	var experience_pixel_offset = (192-(percent_experience * 192))/2
	$CanvasLayer/ExperienceBar.scale = Vector2(percent_experience, 1)
	$CanvasLayer/ExperienceBar.position = Vector2(base_experience_bar_position.x - experience_pixel_offset, base_experience_bar_position.y)
	
	