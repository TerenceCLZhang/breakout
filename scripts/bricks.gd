extends Node2D

@onready var brick = preload("res://scenes/brick.tscn")


func _ready() -> void:
	set_bricks()


func set_bricks():
	var brick_length = 79
	var screen_length = get_viewport_rect().size.x
	var num_bricks_per_row = screen_length / brick_length
	
	var start_x = 5
	var y = 100
	
	for i in range(5):
		var x = start_x 
		for j in range(num_bricks_per_row):
			var new_brick = brick.instantiate()
			new_brick.get_child(0).color = Global.BRICK_COLORS[i]
			new_brick.position = Vector2(x, y)
			add_child(new_brick)
			x += brick_length
		y += 40
