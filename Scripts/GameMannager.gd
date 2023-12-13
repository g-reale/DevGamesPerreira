extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	get_tree().change_scene("res://SelecaoFases.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_ProximaPagina_pressed():
	get_tree().change_scene("res://SelecaoFases2.tscn")


func _on_ProximaPagina2_pressed():
	get_tree().change_scene("res://SelecaoFases3.tscn")


func _on_PaginaAnterior_pressed():
	get_tree().change_scene("res://SelecaoFases.tscn")


func _on_PaginaAnterior2_pressed():
	get_tree().change_scene("res://SelecaoFases2.tscn")
