extends Node2D

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/levels/Level1.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")
