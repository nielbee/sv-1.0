extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	#$AnimationPlayer.play("show")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setPesan(pesan : String):
	$NinePatchRect/Label.text = pesan
func showPopUp():
	$AnimationPlayer.play("show")

func setDurasi(waktu : float) : 
	$Timer.set("wait_time",waktu)
	
func destroyPopUp():
	$AnimationPlayer.play("disolve")
	await $AnimationPlayer.animation_finished
	$".".queue_free()


func _on_timer_timeout():
	destroyPopUp()
