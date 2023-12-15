extends TextureButton
signal activated
signal desapeared

@onready var animation = get_node("AnimationPlayer")
var finished = false

func _ready():
	self.pivot_offset = Vector2(self.size/2)
 
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shake":
		activated.emit()
	elif anim_name == "desapear" and !finished: #desapeared
		desapeared.emit()
		visible = false
		finished = true 
	elif anim_name == "desapear" and finished:  #reapeared
		finished = false



var animation_speed = 1
func set_speed(speed):
	animation_speed = speed

func _on_pressed():
	animation.play("shake")

func desapear():
	animation.play("desapear",-1,animation_speed,false)

func reapear():
	visible = true
	animation.play_backwards("desapear")
	
