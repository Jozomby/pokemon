extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = "down"
var frame_count = 0
var moving = false
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame_count += delta
	if moving:
		if frame_count < 0.75:
			movePlayer()
		else:
			if direction == "right":
				$Sprite/AnimationPlayer.play("stopRight")
			elif direction == "left":
				$Sprite/AnimationPlayer.play("stopLeft")
			elif direction == "down":
				$Sprite/AnimationPlayer.play("stopDown")
			elif direction == "up":
				$Sprite/AnimationPlayer.play("stopUp")
			frame_count = 0
			moving = false
	else:
		if frame_count > 2:
			direction = chooseDirection()
			frame_count = 0
			moving = true

func movePlayer():
	var velocity = Vector2.ZERO
	if direction == "right":
		velocity.x = 1
		velocity.y = 0
		$Sprite/AnimationPlayer.play("walkRight")
	elif direction == "left":
		velocity.x = -1
		velocity.y = 0
		$Sprite/AnimationPlayer.play("walkLeft")
	elif direction == "down":
		velocity.y = 1
		velocity.x = 0
		$Sprite/AnimationPlayer.play("walkDown")
	elif direction == "up":
		velocity.y = -1
		velocity.x = 0
		$Sprite/AnimationPlayer.play("walkUp")
	var velocityValue = velocity.normalized() * speed
	move_and_slide(velocityValue)
	
func chooseDirection():
	var random_dir = randi()%100
	if random_dir < 25:
		return "down"
	if random_dir < 50:
		return "left"
	if random_dir < 75:
		return "right"
	return "up"