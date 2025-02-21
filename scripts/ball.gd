extends CharacterBody2D

const INIT_SPEED := 200.0
var init_directions = [Vector2(-INIT_SPEED, INIT_SPEED), Vector2(INIT_SPEED, INIT_SPEED)]
var direction: Vector2
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	position = Vector2((get_viewport().size.x - $ColorRect.size.x) / 2, 300)
	var index = rng.randi_range(0, 1)
	direction = init_directions[index] 


func _process(delta: float) -> void:
	var collision = move_and_collide(direction * delta)
	
	if collision:
		direction = direction.bounce(collision.get_normal())
	
		var collider = collision.get_collider()
		if collider is Player:
			collider.play_hit_sound()
		if collider is Brick:
			collider.hit()
		if collider.name == "Roof":
			get_parent().change_paddle_length()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$BallCout.play()
	await $BallCout.finished
	get_parent().ball_out()
	queue_free()


func set_speed(speed_increase: float = 1.0):
	direction = Vector2(direction.x * speed_increase, direction.y * speed_increase)


func get_current_speed() -> float:
	return direction.x
