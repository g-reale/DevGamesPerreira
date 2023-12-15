extends Control


const letter_scene = preload("res://game/letterButton.tscn")
const win_sound = preload("res://game/assets/win.wav")
const lose_sound = preload("res://game/assets/lose.wav")

@onready var questions = get_node("questionsBox")
@onready var player = get_node("WinLosePlayer")
@onready var ui = get_node("ui")

signal sigkill

#coordinates of the image's windows
var windows = [Vector2(962, 645),
   			   Vector2(962, 789),
		   	   Vector2(962, 950),
			   Vector2(1220,645),
			   Vector2(1220,789),
			   Vector2(1350,322),
			   Vector2(1350,451),
			   Vector2(1746,557),
			   Vector2(1746,735),
			   Vector2(1746,910)]

const winner_amount = 4
var playing = false

func _ready():
	#resizes the image to fit the screen
	#this is done only once. No need to preload stuff 
	var bkg = get_node("Background")
	var frg = get_node("Foreground")
	var view_port = get_viewport_rect().size
	var scale_factor = view_port / Vector2(1920,1080)
	bkg.scale = scale_factor
	frg.scale = scale_factor

	#seeds the randomizer
	randomize()
	
func _on_ui_play():
	setup_run()
	playing = true

func _on_ui_restart():
	if playing:
		reset()
	
var points = 0
func _on_sucess(letter):
	questions.mark_as_done(letter)
	points = points + 1
	if points == winner_amount:
		won()

var hp = 2
func _on_failure(_letter):
	hp = hp - 1
	ui.show_dmg(hp)
	if hp == 0:
		lost()

func won():
	player.stream = win_sound
	ui.show_particles() 
	player.play()
	reset()
	pass

func lost():
	player.stream = lose_sound 
	player.play()
	reset()
	pass

func reset():
	playing = false
	sigkill.emit()
	questions.reset()
	ui.reset()
	hp = 2
	points = 0

func setup_run():
	
	#scrambles the letters for this run
	var alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
	_scramble(alphabet,255)
	
	#scrambles the windows indexes, the first winner_amount ones will be the winners 
	var winners = []
	for i in range(windows.size()):
		winners.append(i)
	_scramble(winners,255)
	
	#instantiates, translates, scales and connects the letters 
	var scale_factor = get_viewport_rect().size / Vector2(1920,1080)
	for i in range(windows.size()):
		var role = true if i < winner_amount else false
		var window = windows[winners[i]] * scale_factor
		
		var letter = letter_scene.instantiate()
		add_child(letter)
		
		letter.set("theme_override_font_sizes/font_size",100 * scale_factor.length())
		letter.set("text",alphabet[winners[i]])
		letter.set("role",role)
		letter.position = window - letter.size/2
		
		var stagger = randf()
		stagger -= floor(stagger)
		letter.animate(stagger)
		
		letter.connect("sucess",_on_sucess)
		letter.connect("failure",_on_failure)
		self.connect("sigkill",letter._on_sigkill)
		
		#if this is a winner letter write it int the questionsBox
		if role:
			questions.append_question(alphabet[winners[i]],stagger,scale_factor.length())

func _scramble(list,rounds):
	for i in range(rounds):
		var idxa = randi() % list.size()
		var idxb = randi() % list.size()
		
		var aux = list[idxa]
		list[idxa] = list[idxb]
		list[idxb] = aux
