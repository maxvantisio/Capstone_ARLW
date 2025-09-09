extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 2
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75



var target_velocity = Vector3.ZERO

#set the current state as idle since no button is being pressed
var curr_state = "idleAnim"

func _ready():
	#$Pivot/tempCharacterOOPS2/AnimationPlayer.play("idleAction")
	#$Pivot/tempCharacterOOPS2/AnimationPlayer.speed_scale = 1.5
	$Pivot/tempCharacterEditedbackup2/AnimationPlayer.play("idleAnim")

func check_state(new_state: String) -> void:
	if new_state != curr_state:
		$Pivot/tempCharacterEditedbackup2/AnimationPlayer.play(new_state)
		curr_state = new_state

func _physics_process(delta):
	var direction = Vector3.ZERO

#TODO: clean all of this up
	if Input.is_action_pressed("move_right"):
		check_state("walk4")
		direction.x -= .75
	if Input.is_action_pressed("move_left"):
		check_state("walk4")
		direction.x += .75
	if Input.is_action_pressed("move_back"):
		check_state("walk4")
		direction.z -= .75
	if Input.is_action_pressed("move_forward"):
		check_state("walk4")
		direction.z += .75
	
	if Input.is_action_just_released("move_right"):
		check_state("idleAnim")
	if Input.is_action_just_released("move_left"):
		check_state("idleAnim")
	if Input.is_action_just_released("move_back"):
		check_state("idleAnim")
	if Input.is_action_just_released("move_forward"):
		check_state("idleAnim")

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		$Pivot.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
