extends Node2D

# This runs when the Easy button is clicked
func _on_easy_pressed() -> void:
	Global.gamelvl = 0
	Global.randomize_expert_accuracies() # Call the function we just fixed
	get_tree().change_scene_to_file("res://scenes/world.tscn") # Move to the game

# This runs when the Hard button is clicked
func _on_hard_pressed() -> void:
	Global.gamelvl = 1 # Per your instructions: 1 for hard
	Global.randomize_expert_accuracies()
	get_tree().change_scene_to_file("res://scenes/world.tscn")
