extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Label2.text = "Time Taken: " + str(Global.day_number) + " Days"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_scene():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed() -> void:
	call_deferred("change_scene")
