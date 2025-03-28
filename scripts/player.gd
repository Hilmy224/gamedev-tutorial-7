extends CharacterBody3D

@export var speed: float = 20.0
@export var sprint_speed: float = 40.0
@export var crouch_speed: float = 10.0
@export var acceleration: float = 40.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var standing_collision_shape: CollisionShape3D = $standing_collision_shape
@onready var crouching_collision_shape: CollisionShape3D = $crouching_collision_shape


var camera_x_rotation: float = 0.0
var current_speed: float = speed
var sprinting = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation	

func _physics_process(delta):
	var movement_vector = Vector3.ZERO
	
	
	# Movement directions

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x
	
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	# Crouch (hold to activate)
	elif  Input.is_action_pressed("crouch"):
		current_speed = crouch_speed
		# Switch to crouching collision shape
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
		head.position.y = lerp(head.position.y, 1.0, delta * 10)
	else:
		# Return to normal when not crouching
		current_speed = speed
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		# Return camera to standing height
		head.position.y = lerp(head.position.y, 1.8, delta * 10)
	
	movement_vector = movement_vector.normalized()
	
	# Smooth acceleration
	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)
	
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power
	
	move_and_slide()
