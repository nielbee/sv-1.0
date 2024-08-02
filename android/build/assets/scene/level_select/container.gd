extends Node2D
var whoosh_sfx := preload("res://assets/SFX/whoosh-6316.mp3")
var denied_sfx := preload("res://assets/SFX/denied.mp3")
var close_sfx :=preload("res://assets/SFX/switch-light-04-82204.mp3")
@onready var LabelDeskripsi = $"CONTAINER_ANCHOR/Panel/deskripsi_div/ScrollContainer/Label-bak"
@onready var labeljudul = $CONTAINER_ANCHOR/Panel/LabelJudul
@onready var default_thumbnail_texture := preload("res://assets/icon/live_tv_24dp_FILL0_wght400_GRAD0_opsz24.png")
@onready var index_level := 0
const treshold := 30
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	$HTTPRequestGetThumbnail.download_file="user://thumbnailyt.jpg"
	AutoloadSvGlobal.connect("get_materi",load_materi)
	hideAllexcept(index_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if Input.is_action_just_pressed("ui_down"):
		next_level()
	elif Input.is_action_just_pressed("ui_up"):
		#$AnimationPlayer.play("prev")
		prev_level()

func _input(event):
	if(event is InputEventSingleScreenSwipe) :
		print(event.relative)
		
		if  event.relative.y < -treshold : 
			next_level()
		elif event.relative.y > treshold : 
			prev_level()



func next_level():
	if index_level < 2:
		$sfx.set("stream",whoosh_sfx)
		index_level+=1
		$AnimationPlayer.play("next")
	else:
		$sfx.set("stream",denied_sfx)
	$sfx.play()
	print(index_level)
	hideAllexcept(index_level)
	await($AnimationPlayer.animation_finished)
func prev_level():
	if index_level > 0:
		$sfx.set("stream",whoosh_sfx)
		index_level -=1
		$AnimationPlayer.play("prev")
	else:
		$sfx.set("stream",denied_sfx)
	$sfx.play()
	print(index_level)
	hideAllexcept(index_level)
	await($AnimationPlayer.animation_finished)
	
func load_materi():
	$CONTAINER_ANCHOR/Panel/thumbnail.texture = default_thumbnail_texture
	LabelDeskripsi.text = AutoloadSvGlobal.materi[index_level]["deskripsi"]
	labeljudul.text = AutoloadSvGlobal.materi[index_level]["materi"]
	print(AutoloadSvGlobal.materi[index_level]["thumbnail"])
	$HTTPRequestGetThumbnail.request(AutoloadSvGlobal.materi[index_level]["thumbnail"])

func hideAllexcept(level : int):
	$dot1/dot_active.visible = false
	$dot2/dot_active.visible = false
	$dot3/dot_active.visible = false
	if level == 0:
		$dot1/dot_active.visible = true
	elif level == 1 :
		$dot2/dot_active.visible = true
	elif level == 2:
		$dot3/dot_active.visible = true


func _on_button_close_pressed():
	$".".hide()


func _on_http_request_get_thumbnail_request_completed(result, response_code, headers, body):
	var image = Image.load_from_file("user://thumbnailyt.jpg")
	var tekstur = ImageTexture.create_from_image(image)
	$CONTAINER_ANCHOR/Panel/thumbnail.texture = tekstur
	


func _on_button_kuis_pressed():
	#print(AutoloadSvGlobal.materi[index_level])
	SoalSV.setIdStage(AutoloadSvGlobal.materi[index_level]["id"])
	var data = {
		"materi":AutoloadSvGlobal.materi[index_level]["id"],
		"token": AutoloadSvGlobal.token
	}
	AutoloadSvGlobal.makeRequest("https://api.sekolahvirtual.org/getSoal.php",data,AutoloadSvGlobal.ACTION_LIST.SAVE_TO_SOAL)


func _on_button_video_pressed():
	OS.shell_open(AutoloadSvGlobal.materi[index_level]["link_video"])




func _on_button_prev_pressed():
	prev_level()


func _on_button_next_pressed():
	next_level()
