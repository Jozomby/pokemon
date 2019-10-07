extends KinematicBody2D

export var speed = 100
export var grid_size = 32
var screen_size
var animation_frame = 0
var targetPosition = Vector2()
var velocity = Vector2()
var moving = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Only change velocity when the player stops moving.
	if !moving:
		if Input.is_action_pressed("ui_right"):
			velocity.x = 1
			velocity.y = 0
			$Sprite/AnimationPlayer.play("walkRight")
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -1
			velocity.y = 0
			$Sprite/AnimationPlayer.play("walkLeft")
		elif Input.is_action_pressed("ui_down"):
			velocity.y = 1
			velocity.x = 0
			$Sprite/AnimationPlayer.play("walkDown")
		elif Input.is_action_pressed("ui_up"):
			velocity.y = -1
			velocity.x = 0
			$Sprite/AnimationPlayer.play("walkUp")
	
	# Calculate the current grid position, the target grid position, and
	# don't stop moving until the character is in the target grid position
	var currentPosition = get_grid_position(position, Vector2(0,0))
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		if currentPosition == targetPosition:
			moving = false
		else: 
			moving = true
		# If the movement keys are still down, update the target position
		targetPosition = get_grid_position(position, velocity)
	else:
		if currentPosition == targetPosition or get_slide_count() > 0:
			stop_player()
	
	
	var velocityValue = velocity.normalized() * speed
	move_and_slide(velocityValue)

func get_grid_position(pos, vel):
	print(vel.x > 0)
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

