extends Node2D

@onready var angin := preload("res://scene/effect/windgust/WindGust.tscn")
@onready var mainMenuScene := preload("res://scene/main/main.tscn")

func _ready():
	$Panel/Logo/logo_sv_anim.play("glow_effect")
	
	Firebase.Auth.userdata_received.connect(OnUserDataFetched)

func _on_google_sign_in_button_login_berhasil():
	get_tree().change_scene_to_packed(mainMenuScene)
	
	
func OnUserDataFetched(data):
	print(data)

	
	AutoloadSvGlobal.makeRequest("https://api.sekolahvirtual.org/getSoal.php",data,AutoloadSvGlobal.ACTION_LIST.SAVE_TO_TOKEN)


#ini untuk effek sa ee, jang ganti
func _on_google_sign_in_button_mouse_entered():
	$Panel/AnimationPlayer.play("expand_and_shrink")
	$Panel/GoogleSignInButton/AudioStreamPlayer2D.play()



func _on_google_sign_in_button_mouse_exited():
	$Panel/AnimationPlayer.play_backwards("expand_and_shrink")
	$Panel/GoogleSignInButton/AudioStreamPlayer2D.play()
	
#UNTUK EFEK ANGIN PAKE TIMER


func _on_timer_efek_angin_timeout():
	var newAngin = angin.instantiate()
	$background/INSTANCE_EFFEK_DISINI.add_child(newAngin)
	newAngin.set("position",Vector2(0,randf_range(0,200)))
