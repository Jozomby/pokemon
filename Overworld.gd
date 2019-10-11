extends Node2D

var Utils = preload("utils.gd")

var battle = preload("res://Battle.tscn");
var map_map = {
	"Default": preload("res://Route1.tscn"),
	"Route1": preload("res://Route1.tscn"),
	"CaveOfWonders": preload("res://CaveOfWonders.tscn"),
	"Lighthouse": preload("res://Lighthouse.tscn")
	}
	
var current_map = null

var active_pokemon = {}
var opposing_pokemon = {}

func _ready():
	var defaultMap = map_map["Default"].instance()
	add_child(defaultMap)
	current_map = defaultMap
	defaultMap.connect("map_transition", self, "handle_map_transition")
	defaultMap.connect("begin_encounter", self, "handle_begin_encounter")
	initialize_party()
	
func initialize_party():
	active_pokemon = Utils.generatePokemon({"id": 1, "level": 8})
	active_pokemon["current_hp"] = active_pokemon["stats"]["hp"]
	active_pokemon["max_hp"] = active_pokemon["stats"]["hp"]
	active_pokemon["attacks"] = Utils.fillOutAttacks(active_pokemon["attacks"])
	active_pokemon["experience_since_last_level"] = 40
	active_pokemon["experience"] = active_pokemon["experience"] + active_pokemon["experience_since_last_level"]
	active_pokemon["experience_needed"] = Utils.calculateExperience(active_pokemon["growth_rate"], active_pokemon["level"]+1) - active_pokemon["experience"]
	active_pokemon["status"] = ""
	
func handle_map_transition(targetMap, player_position):
	call_deferred("_handle_map_transition", targetMap, player_position)
	
func _handle_map_transition(targetMap, player_position):
	remove_child(current_map)
	current_map.queue_free()
	var new_map = map_map[targetMap].instance()
	new_map.player_position = player_position
	add_child(new_map)
	current_map = new_map
	new_map.connect("map_transition", self, "handle_map_transition")
	new_map.connect("begin_encounter", self, "handle_begin_encounter")

func handle_begin_encounter(pokemon, return_map, return_position):
	call_deferred("_handle_begin_encounter", pokemon, return_map, return_position)
	
func _handle_begin_encounter(pokemon, return_map, return_position):
	remove_child(current_map)
	current_map.queue_free()
	var encounter = battle.instance()
	var wild_pokemon = Utils.generatePokemon(pokemon)
	encounter.active_pokemon = active_pokemon
	encounter.opposing_pokemon = wild_pokemon
	encounter.return_map = return_map
	encounter.return_position = return_position
	encounter.connect("map_transition", self, "handle_map_transition")
	current_map = encounter
	add_child(encounter)