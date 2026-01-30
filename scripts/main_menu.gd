extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.invest_amount_usd = 0.0
	Global.invest_amount_bdt = 0.0
	Global.balance = 500000.00
	Global.day_start = true
	Global.day_number = 0
	Global.usd_profit = 0.0
	Global.bdt_profit = 0.0
	
	Global.djt_guess = 0
	Global.elon_guess = 0
	Global.powell_guess = 0
	Global.yunus_guess = 0
	Global.tarik_guess = 0
	Global.shafiq_guess = 0
	
	Global.first_time_kichir_michir = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_btn_pressed() -> void:
	call_deferred("change_scene")
	
func change_scene():
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")
	
func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_how_to_play_btn_pressed() -> void:
	call_deferred("go_to_how_to_play")
	
func go_to_how_to_play():
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")
