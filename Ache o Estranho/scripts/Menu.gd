extends Node2D

onready var credit_popup = $CreditPopup

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/levels/Level1.tscn")

func _on_Button2_pressed():
	credit_popup.show()

func _on_CreditPopup_pressed():
	credit_popup.hide()

func _on_Button3_pressed():
	get_tree().quit()
