extends KinematicBody2D

export var speed = 100
export var grid_size = 32
var animation_frame = 0
var screen_size
var targetPosition = Vector2()
export var lastPositionOnGrid = Vector2()
var currentVelocity = Vector2()
var velocity = Vector2()
var moving = false
var direction = "down"
const MessageResource = preload("res://Message.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _draw():
	targetPosition = get_grid_position(position, Vector2(0,0))
	lastPositionOnGrid = get_grid_position(position, Vector2(0,0))

func _process(delta):
	var currentPosition = position
	var newTargetPosition = Vector2(0,0)
	var input_pressed = false
	if Input.is_action_pressed("ui_right"):
		input_pressed = true
		velocity.x = 1
		velocity.y = 0
		newTargetPosition.x = lastPositionOnGrid.x + grid_size
		newTargetPosition.y = lastPositionOnGrid.y
		direction = "right"
	elif Input.is_action_pressed("ui_left"):
		input_pressed = true
		velocity.x = -1
		velocity.y = 0
		newTargetPosition.x = lastPositionOnGrid.x - grid_size
		newTargetPosition.y = lastPositionOnGrid.y
		direction = "left"
	elif Input.is_action_pressed("ui_down"):
		input_pressed = true
		velocity.y = 1
		velocity.x = 0
		newTargetPosition.y = lastPositionOnGrid.y + grid_size
		newTargetPosition.x = lastPositionOnGrid.x
		direction = "down"
	elif Input.is_action_pressed("ui_up"):
		input_pressed = true
		velocity.y = -1
		velocity.x = 0
		newTargetPosition.y = lastPositionOnGrid.y - grid_size
		newTargetPosition.x = lastPositionOnGrid.x
		direction = "up"
	else:
		input_pressed = false

	if (currentPosition == targetPosition):
		lastPositionOnGrid.x = targetPosition.x
		lastPositionOnGrid.y = targetPosition.y
		if input_pressed:
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
	var velocityValue = currentVelocity.normalized() * speed
	var collision
	if (abs((velocityValue * delta).x) > abs(currentPosition.x - targetPosition.x) || abs((velocityValue * delta).y) > abs(currentPosition.y - targetPosition.y)):
		collision = move_and_collide(targetPosition-currentPosition)
	else:
		collision = move_and_collide(velocityValue * delta)
	if collision:
		targetPosition.x = lastPositionOnGrid.x
		targetPosition.y = lastPositionOnGrid.y
		if position != targetPosition:
			currentVelocity.x = currentVelocity.x * -1
			currentVelocity.y = currentVelocity.y * -1
	

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

func _unhandled_input(event):
	if event is InputEventKey:
			if event.pressed and event.scancode == KEY_META:
					var message = get_interaction_message()
					if message == null:
						return
					var GrabbedInstance = MessageResource.instance()
					GrabbedInstance.set_message(message)
					var sceneNode = get_node('/root/Overworld')
					sceneNode.add_child(GrabbedInstance)

						
func get_interaction_message():
	var space_state = get_world_2d().direct_space_state
	var direction_vector = Vector2.ZERO
	if direction == "up":
		direction_vector.y = -1
	elif direction == "down":
		direction_vector.y = 1
	elif direction == "left":
		direction_vector.x = -1
	elif direction == "right":
		direction_vector.x = 1
	var result = space_state.intersect_ray(position, position + direction_vector * grid_size, [self])
	if not result.get("collider") == null:
		return result.collider.message
	return null

	