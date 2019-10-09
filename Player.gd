extends KinematicBody2D

export var speed = 100
export var grid_size = 32
var animation_frame = 0
var targetPosition = Vector2()
export var lastPositionOnGrid = Vector2()
var currentVelocity = Vector2()
var velocity = Vector2()

func _draw():
	targetPosition = get_grid_position(position, Vector2(0,0))
	lastPositionOnGrid = get_grid_position(position, Vector2(0,0))

func _process(delta):
	var currentPosition = get_grid_position(position, Vector2(0,0))
	var newTargetPosition = Vector2(0,0)
	var input_pressed = false
	if Input.is_action_pressed("ui_right"):
		input_pressed = true
		velocity.x = 1
		velocity.y = 0
		newTargetPosition.x = currentPosition.x + grid_size
		newTargetPosition.y = currentPosition.y
	elif Input.is_action_pressed("ui_left"):
		input_pressed = true
		velocity.x = -1
		velocity.y = 0
		newTargetPosition.x = currentPosition.x - grid_size
		newTargetPosition.y = currentPosition.y
	elif Input.is_action_pressed("ui_down"):
		input_pressed = true
		velocity.y = 1
		velocity.x = 0
		newTargetPosition.y = currentPosition.y + grid_size
		newTargetPosition.x = currentPosition.x
	elif Input.is_action_pressed("ui_up"):
		input_pressed = true
		velocity.y = -1
		velocity.x = 0
		newTargetPosition.y = currentPosition.y - grid_size
		newTargetPosition.x = currentPosition.x
	else:
		input_pressed = false
	if (currentPosition == targetPosition):
		lastPositionOnGrid.x = currentPosition.x
		lastPositionOnGrid.y = currentPosition.y
		if input_pressed && self.get_slide_count() == 0:
			targetPosition.x = newTargetPosition.x
			targetPosition.y = newTargetPosition.y
			currentVelocity.x = velocity.x
			currentVelocity.y = velocity.y
		else:
			currentVelocity.x = 0
			currentVelocity.y = 0
	if currentVelocity.x == 1:
		$Sprite/AnimationPlayer.play("walkRight")
	elif currentVelocity.x == -1:
		$Sprite/AnimationPlayer.play("walkLeft")
	elif currentVelocity.y == 1:
		$Sprite/AnimationPlayer.play("walkDown")
	elif currentVelocity.y == -1:
		$Sprite/AnimationPlayer.play("walkUp")
	else:
		stop_player()
	if self.get_slide_count() > 0 && currentPosition != targetPosition:
		currentVelocity.x = currentVelocity.x * -1
		currentVelocity.y = currentVelocity.y * -1
		targetPosition.x = lastPositionOnGrid.x
		targetPosition.y = lastPositionOnGrid.y
	var velocityValue = currentVelocity.normalized() * speed
	move_and_slide(velocityValue)
	

func get_grid_position(pos, vel):
	var targetPosition = Vector2()
	if vel.x > 0:
		targetPosition.x = (floor(pos.x / grid_size) + vel.x) * grid_size
	if vel.x <= 0:
		targetPosition.x = (ceil(pos.x / grid_size) + vel.x) * grid_size
	if vel.x == 0:
		targetPosition.x = (round(pos.x / grid_size) + vel.x) * grid_size
	targetPosition.y = (floor(pos.y / grid_size) + vel.y) * grid_size
	return targetPosition
	
func stop_player():
	if velocity.x == 1:
		$Sprite/AnimationPlayer.play("stopRight")
	elif velocity.x == -1:
		$Sprite/AnimationPlayer.play("stopLeft")
	elif velocity.y == 1:
		$Sprite/AnimationPlayer.play("stopDown")
	elif velocity.y == -1:
		$Sprite/AnimationPlayer.play("stopUp")
	velocity.y = 0
	velocity.x = 0

func disable_light():
	$Light2D.enabled = false
func enable_light():
	$Light2D.enabled = true
