extends Node2D

const MAX_BALL_SPEED = 400.0
const BALL_SPEED_INCREASE_RATE = 1.1
var ball_scene = preload("res://scenes/ball.tscn")
var ball: CharacterBody2D

var broken_blue = false
var hit_ceiling = false

var speed_increase := 1.0


func _ready() -> void:
	$UI/HighScore.text = str(Global.save_data.best_score)
	spawn_ball()


func _process(_delta: float) -> void:
	if $Bricks.get_child_count() == 0 and ball.position.y >= 300:
		$Bricks.set_bricks()
		broken_blue = false
		hit_ceiling = false


func score(brick_color: Color):
	var score_increase = Global.BRICK_COLORS.size() - Global.BRICK_COLORS.find(brick_color)
	if score_increase == -1:
		printerr("ERROR: Cannot find color.")
		return
	$UI/Score.text = str(int($UI/Score.text) + score_increase)
	set_best_score()
	change_ball_speed($UI/Score.text, score_increase)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		Engine.time_scale = 1
		get_tree().reload_current_scene()


func spawn_ball():
	await get_tree().create_timer(2).timeout
	ball = ball_scene.instantiate()
	add_child(ball)
	if speed_increase > 1: ball.set_speed(speed_increase)


func ball_out():
	$UI/Life.text = str(int($UI/Life.text) - 1)
	if int($UI/Life.text) <= 0: # Game over
		$GameOverUI/GameOver.play()
		game_over()
		return
	spawn_ball()


func game_over():
	$GameOverUI.visible = true
	Engine.time_scale = 0


func change_ball_speed(current_score: String, score_increase: int):
	if (current_score == "5" or current_score == "15" or (!broken_blue and score_increase == 4)) and ball.get_current_speed() < MAX_BALL_SPEED:
		speed_increase *= BALL_SPEED_INCREASE_RATE
		ball.set_speed(speed_increase)
		if !broken_blue and score_increase == 4: broken_blue = true


func change_paddle_length():
	if !hit_ceiling:
		hit_ceiling = true
		$Player.halve_paddle()


func set_best_score() -> void:
	if int($UI/Score.text) > Global.save_data.best_score:
		Global.save_data.best_score = int($UI/Score.text)
		Global.save_data.save()
		$UI/HighScore.text = $UI/Score.text
