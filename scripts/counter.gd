extends HBoxContainer

@export var var_name: String = "djt_guess"
@onready var value_label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _modify_value(amount: int):
	# Use get() and set() to dynamically access the Global autoload
	var current_val = Global.get(var_name)
	if current_val != null:
		Global.set(var_name, current_val + amount)
		update_display()
	else:
		push_error("Variable '" + var_name + "' not found in Global script!")
	
func update_display():
	value_label.text = str(Global.get(var_name))


func _on_minus_pressed() -> void:
	if Global.get(var_name) > 0:
		_modify_value(-1)


func _on_plus_pressed() -> void:
	if Global.get(var_name) < 10:
		_modify_value(+1)
