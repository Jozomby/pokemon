extends Node2D

var Utils = preload("utils.gd")

var battle = preload("res://Battle.tscn");
var map_map = {
	"Default": preload("res://Route1.tscn"),
	"Route1": preload("res://Route1.tscn"),
	"CaveOfWonders": preload("res://CaveOfWonders.tscn")
	}
	
var current_map = null

var active_pokemon = {
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
var opposing_pokemon = {
	"id": 16,
	"name": "Pidgey",
	"gender": "female",
	"max_hp": 16,
	"current_hp": 16,
	"level": 4,
	"shiny": false
}

func _ready():
	var defaultMap = map_map["Default"].instance()
	add_child(defaultMap)
	current_map = defaultMap
	defaultMap.connect("map_transition", self, "handle_map_transition")
	defaultMap.connect("begin_encounter", self, "handle_begin_encounter")
	
func handle_map_transition(targetMap):
	remove_child(current_map)
	current_map.queue_free()
	var new_map = map_map[targetMap].instance()
	add_child(new_map)
	current_map = new_map
	new_map.connect("map_transition", self, "handle_map_transition")
	new_map.connect("encounter", self, "handle_encounter")

func handle_begin_encounter(pokemon, return_map):
	remove_child(current_map)
	current_map.queue_free()
	var encounter = battle.instance()
	var wild_pokemon = Utils.generatePokemon(pokemon)
	wild_pokemon.max_hp = wild_pokemon["stats"]["hp"]
	wild_pokemon.current_hp = wild_pokemon["stats"]["hp"]
	encounter.active_pokemon = active_pokemon
	encounter.opposing_pokemon = wild_pokemon
	encounter.return_map = return_map
	encounter.connect("map_transition", self, "handle_map_transition")
	current_map = encounter
	add_child(encounter)