extends Node2D

var map_map = {
	"Default": preload("res://Route1.tscn"),
	"Route1": preload("res://Route1.tscn"),
	"CaveOfWonders": preload("res://CaveOfWonders.tscn")
	}
	
var current_map = null

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
	print("Encountering:")
	print(pokemon)