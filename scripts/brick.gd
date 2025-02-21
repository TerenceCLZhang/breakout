extends StaticBody2D

class_name Brick


func hit():
	get_parent().get_parent().score($ColorRect.color)
	$Destroyed.play()
	visible = false
	$CollisionShape2D.disabled = true
	await $Destroyed.finished
	queue_free()
