extends CharacterBody2D

class_name Player

@export var speed := 250.0
const MIN_PADDLE_LENGTH = 50.0


func _ready() -> void:
	position = Vector2((get_viewport().size.x - $ColorRect.size.x) / 2, 550)


func _process(_delta: float) -> void:
	velocity.x = 0
	velocity.y = 0
	move_player()
	move_and_slide()


func move_player():
	if Input.is_action_pressed("left") and check_wall():
		velocity.x -= speed
	if Input.is_action_pressed("right") and check_wall():
		velocity.x += speed 


func check_wall():
	return position.x >= 5 and position.x + $ColorRect.size.x <= get_viewport_rect().size.x - 5


func halve_paddle():
	if $ColorRect.size.x > MIN_PADDLE_LENGTH:
		$ColorRect.size.x /= 2
		$CollisionShape2D.shape.extents.x /= 2
		$CollisionShape2D.position.x /= 2


func play_hit_sound():
	$Hit.play()
