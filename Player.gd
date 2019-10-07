extends KinematicBody2D

export var speed = 100
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$Sprite/AnimationPlayer.play("walkRight")
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$Sprite/AnimationPlayer.play("walkLeft")
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$Sprite/AnimationPlayer.play("walkDown")
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$Sprite/AnimationPlayer.play("walkUp")
	else:
		$Sprite/AnimationPlayer.stop()
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
