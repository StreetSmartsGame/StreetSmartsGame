extends Control

@onready var player_a = $BadSound
@onready var player_b = $Instructor

func _ready() -> void:
	player_a.connect("finished", Callable(self, "_on_player_a_finished"))
	player_a.play()

func _on_player_a_finished() -> void:
	player_b.play()

func _on_button_pressed() -> void:
	print("Restart pressed")
	get_tree().change_scene_to_file("res://Scenes/main.tscn")  # Restart gameplay

func _on_return_menu_pressed() -> void:
	print("Return to Menu pressed")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
