extends Node3D

@onready var worldEnv : WorldEnvironment = $WorldEnvironment
@onready var dirLight := $DirectionalLight3D
@onready var spotLight := $SpotLight3D
@onready var nightNoise := $NightNoise
@onready var dayNoise := $DayNoise

var is_day : bool = true # Track current state locally
var transition_time : float = 2.0 # How many seconds the transition lasts

func _ready() -> void:
	is_day = Global.day_start
	update_visuals(1) # Set initial state instantly

func _process(_delta: float) -> void:
	# Only trigger the tween if the global state has changed
	if Global.day_start != is_day:
		is_day = Global.day_start
		update_visuals(transition_time)

func update_visuals(duration: float):
	var sky_mat = worldEnv.environment.sky.sky_material
	if not sky_mat is ProceduralSkyMaterial: return

	# Create a tween to animate properties over time
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	if is_day:
		# Transition to Day colors
		spotLight.visible = false
		nightNoise.stop()
		dayNoise.play()
		tween.tween_property(sky_mat, "sky_top_color", Color("#a5a7ab"), duration)
		tween.tween_property(sky_mat, "sky_horizon_color", Color("#909297"), duration)
		tween.tween_property(sky_mat, "ground_horizon_color", Color("#909297"), duration)
		tween.tween_property(sky_mat, "ground_bottom_color", Color("#a5a7ab"), duration)
		
		# Fade out spotlights and increase sun energy
		tween.tween_property(spotLight, "light_energy", 0.0, duration)
		tween.tween_property(dirLight, "light_energy", 1.0, duration)
	else:
		# Transition to Night colors
		tween.tween_property(sky_mat, "sky_top_color", Color("#050521"), duration)
		tween.tween_property(sky_mat, "sky_horizon_color", Color("#1a1a4d"), duration)
		tween.tween_property(sky_mat, "ground_horizon_color", Color("#1a1a4d"), duration)
		tween.tween_property(sky_mat, "ground_bottom_color", Color("#050521"), duration)
		
		# Fade in spotlights and dim the sun
		spotLight.visible = true # Ensure it's visible so we can see the fade
		dayNoise.stop()
		nightNoise.play()
		tween.tween_property(spotLight, "light_energy", 1.0, duration)
		tween.tween_property(dirLight, "light_energy", 0.1, duration)
