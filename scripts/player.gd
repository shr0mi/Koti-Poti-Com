extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var sensitivity := 0.003
@export var smoothness := 20
var yaw := 0.0
var pitch := 0.0

@onready var raycast = $CameraPivot/RayCast3D
var max_interaction_distance = 3.0

# Day Label show
@onready var fade_overlay = $CanvasLayer/ColorRect
@onready var day_label = $CanvasLayer/DayLabel

@onready var progress_bar = $CanvasLayer/HideWhenAnimation/ProgressBar
@onready var goToBed := $CanvasLayer/HideWhenAnimation/GoToBed
@onready var goToPC := $CanvasLayer/HideWhenAnimation/GoToPC

func _ready() -> void:
	print(Global.day_start)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	progress_bar.value = (Global.balance / Global.target) * 100.0
	
func _process(delta: float) -> void:
	look_controls(delta)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	check_raycast()
	
	move_and_slide()
	
	if Global.day_start:
		goToPC.visible = true
		goToBed.visible = false
	else:
		#print("hmmm")
		goToPC.visible = false
		goToBed.visible = true
	
	
func look_controls(delta):
	if Input.is_action_just_pressed("ESCAPE"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		call_deferred("go_to_menu")
	
	rotation.y = lerp_angle(rotation.y, yaw, delta * smoothness)
	$CameraPivot.rotation.x = lerp_angle($CameraPivot.rotation.x, pitch, delta * smoothness)

func go_to_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		pitch = clamp(pitch, deg_to_rad(-90), deg_to_rad(90))
		
func check_raycast():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var distance = global_position.distance_to(raycast.get_collision_point())
		
		if distance <= max_interaction_distance:
			# Check if it's a bed or computer
			if collider.is_in_group("bed") and not Global.day_start:
				#print("Looking at bed - Press E to interact")
				$CanvasLayer/Label.visible = true
				# Your interaction logic here
				if Input.is_action_just_pressed("interact"):
					# new day start
					Global.day_number += 1 #add day
					Global.day_start = true
					show_day_transition()
			
			elif collider.is_in_group("computer") and Global.day_start:
				#print("Looking at computer - Press E to interact")
				# Your interaction logic here
				$CanvasLayer/Label.visible = true
				if Input.is_action_just_pressed("interact"):
						Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
						call_deferred("change_scene")
						
			else:
				$CanvasLayer/Label.visible = false
		else:
			$CanvasLayer/Label.visible = false
	else:
			$CanvasLayer/Label.visible = false
						
func change_scene():
	get_tree().change_scene_to_file("res://scenes/browser.tscn")
	
func show_day_transition():
	$CanvasLayer/HideWhenAnimation.visible = false
	# Fade to black
	var tween = create_tween()
	fade_overlay.visible = true
	tween.tween_property(fade_overlay, "modulate:a", 1.0, 0.5)
	await tween.finished
	
	# Show day text
	day_label.text = "Day " + str(Global.day_number)
	day_label.visible = true
	await get_tree().create_timer(1.5).timeout
	day_label.visible = false
	
	# Fade back
	tween = create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 0.0, 0.5)
	await tween.finished
	fade_overlay.visible = false
	
	$CanvasLayer/HideWhenAnimation.visible = true
	
