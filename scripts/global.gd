extends Node

const BRICK_COLORS = [Color(255, 0, 255, 1), Color(0, 0, 255, 1), Color(0, 255, 0, 1), Color(255, 255, 0, 1), Color(255, 0, 0, 1)]
var save_data: SaveData


func _ready() -> void:
	save_data = SaveData.load_or_create()
