extends Node2D

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/GameOver.tscn")

func _on_RightButton_pressed():
	get_tree().change_scene("res://scenes/levels/Level10.tscn")
