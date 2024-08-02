extends Node2D

func _notification(what):
	match what:
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
			$BG/AudioStreamPlayer2D.set("volume_db",-80)
		MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
			$BG/AudioStreamPlayer2D.set("volume_db",-3)
			#pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$Container.hide()
	AutoloadSvGlobal.connect("buka_container_deskripsi",tampilkanMateri)
	print(AutoloadSvGlobal.token)
	
	$WorldEnvironment/effek_cahaya.play("ligth_effect")

func  tampilkanMateri():
	$Container.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
