extends Node2D

var labels = preload("res://game/letterButton.tscn")
var font = preload("res://game/assets/PlaypenSans-Bold.ttf")
var questions = {}

var finished = false
var child_count = 0
var x_offset = 0

signal sigkill

func append_question(answer,from,scale_factor):

	if  not questions.has(answer):
		questions[answer] = labels.instantiate()
		add_child(questions[answer])
		
		questions[answer].text = answer.to_upper()
		questions[answer].disabled = true
		questions[answer].set("theme_override_font_sizes/font_size",100 * scale_factor)
		questions[answer].set("theme_override_fonts/font",font)
		
		questions[answer].position.x = questions[answer].position.x + x_offset 
		x_offset = x_offset + questions[answer].size.x
		
		questions[answer].animate(from,0.5)
		self.connect("sigkill",questions[answer]._on_sigkill)
		
		
	child_count = child_count + 1

func mark_as_done(answer):
	if questions.has(answer):
		questions[answer].indicate_sucess()
		
func reset():
	sigkill.emit()
	questions.clear()
	x_offset = 0

func _on_sigkill():
	reset()
	if child_count == 0:
		self.queue_free()
	else:
		finished = true
		
func _on_child_exiting_tree(_node):
	child_count = child_count -1
	if child_count == 0 and finished:
		self.queue_free()
