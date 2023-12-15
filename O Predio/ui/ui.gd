extends Control

signal play
signal restart

const snd_on_off_textures = [preload("res://ui/assets/on_off som/caixaSom2.png"),
							 preload("res://ui/assets/on_off som/caixaSom.png")]


@onready var restart_btn = get_node("upper/restart")
@onready var sound_btn = get_node("upper/sound")
@onready var play_btn = get_node("central/play")
@onready var lifebar = get_node("lifeAnimations")
@onready var particles = get_node("particleAnimations")

#inital load conditions
#happens only once, no need to preload anything
func _ready():
	get_node("life").texture = load("res://ui/assets/corações/cheio.png")
	get_node("particles").emitting = false
	
func _on_play_activated():
	play_btn.desapear()
	
func _on_play_desapeared():
	play.emit()
	
func _on_restart_activated():
	restart.emit()

func _on_sound_pressed():
	toggle_volume()

var mute = false
func toggle_volume():
	mute = not mute
	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus,mute)
	sound_btn.set("texture_normal",snd_on_off_textures[int(mute)])
	
func reset():
	play_btn.reapear()
	lifebar.revive()

func show_dmg(dmg):
	lifebar.show_dmg(dmg)

func show_particles():
	particles.play("peek")
	



