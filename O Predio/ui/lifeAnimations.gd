extends AnimationPlayer
	
func show_dmg(hp):
	
	match hp:
		1:
			play("hurt")
		0:
			play("die")

func revive():
	play("revive")
