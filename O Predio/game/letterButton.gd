extends Button

@export var role = true
@export var offset = Vector2(0,0)
@onready var player = get_node("FailureSucessPlayer")
@onready var animation_bounce = get_node("BouncePlayer")
@onready var animation_fade = get_node("FadeInPlayer")

signal sucess(letter)
const sucess_color = Color(0,255,0)
const sucess_sound = preload("res://game/assets/sucess.wav")

signal failure(letter)
const failure_color = Color(255,0,0)
const failure_sound = preload("res://game/assets/failure.wav") 

var reference_position = Vector2(0,0)
var animation_speed = 1
var finished = false

func _ready():
	self.pivot_offset = self.size/2
	self.position = -self.size/2
	self.visible = false
	
	
func animate(from,speed=1):
	animation_speed = speed
	animation_fade.play("fadeIn",-1,animation_speed,false)
	animation_bounce.play("bounce",-1,animation_speed,false)
	animation_bounce.seek(from)
	self.visible = true
	reference_position = self.position

func indicate_sucess():
	self.disabled = true
	add_theme_color_override("font_disabled_color",sucess_color)

func indicate_failure():
	self.disabled = true
	add_theme_color_override("font_disabled_color",failure_color)
	
func _physics_process(_delta):
	if animation_bounce.is_playing():
		self.position = reference_position + offset

func _on_pressed():
	match role:
		#loser
		false:
			player.stream = failure_sound
			indicate_failure()
			failure.emit(self.text)
		#winner
		true:
			player.stream = sucess_sound
			indicate_sucess()
			sucess.emit(self.text)
		
	player.play()
	destroy()

func _on_bounce_player_animation_finished(_anim_name):
	if !finished:
		animation_bounce.play("bounce",-1,animation_speed,false)

func _on_sigkill():
	destroy()
	
func destroy():
	animation_fade.play_backwards("fadeIn")
	finished = true
	
func _clear(_anim_name=""):
	if finished:
		self.queue_free()
