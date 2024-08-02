extends Node2D


var id_stage : String
signal selesaiSoal
const baseUrlGambar = "https://sekolahvirtual.org/app/uploads/"
@onready var bintang := 0
@onready var nomor := 0
var jawaban := ""
@onready var cekbox_ok := preload("res://assets/icon/cekbox_isi.png")
@onready var cekbox_no := preload("res://assets/icon/cekbox_kosong.png")




func _ready()->void:
	AutoloadSvGlobal.connect("get_soal",mulaiAwal)


func setIdStage(id : String):
	
	id_stage = id
	print("set id berhasil : "+ id_stage)
	bintang = 0
	#mulaiAwal()


func simpanBintang():
	$Panel/AnimationPlayer.play("selesai popUP")
	await $Panel/AnimationPlayer.animation_finished
	if bintang == 0:
		$AudioNilai.set("stream","res://assets/SFX/denied.mp3")
		$AudioNilai.play
	if bintang == 1 : 
		$AudioNilai.set("stream","res://assets/SFX/denied.mp3")
		$AudioNilai.play()
		$Panel/AnimationPlayer.play("bintang1")
		await $Panel/AnimationPlayer.animation_finished
	if bintang == 2 :
		$AudioNilai.set("stream","res://assets/SFX/interface-1-126517.mp3")
		$AudioNilai.play
		$Panel/AnimationPlayer.play("bintang1")
		await $Panel/AnimationPlayer.animation_finished
		$Panel/AnimationPlayer.play("bintang2")
		await $Panel/AnimationPlayer.animation_finished
	if bintang == 3 :
		$AudioNilai.set("stream","res://resource/assets/audio/short-success-sound-glockenspiel-treasure-video-game-6346.mp3")
		$AudioNilai.play
		$Panel/AnimationPlayer.play("bintang1")
		await $Panel/AnimationPlayer.animation_finished
		$Panel/AnimationPlayer.play("bintang2")
		await $Panel/AnimationPlayer.animation_finished
		$Panel/AnimationPlayer.play("bintang3")
		await $Panel/AnimationPlayer.animation_finished
	var data = {
		"token": AutoloadSvGlobal.token,
		"id_stage":id_stage,
		"benar":bintang
	}
	$HTTPRequest.request("https://api.sekolahvirtual.org/saveBintang.php",[],HTTPClient.METHOD_POST,JSON.stringify(data))
	#kalau bintang 3, unlock mapel
	#if bintang == 3:
		#pass
	#if sv.soal_terakhir:
		#pass
	
	nomor = 0
	bintang = 0


func _tombol_next_ditekan():
	if $Panel/ButtonA.button_pressed:
		jawaban = jawaban+"A"
	if $Panel/ButtonB.button_pressed:
		jawaban = jawaban+"B"
	if $Panel/ButtonC.button_pressed:
		jawaban = jawaban+"C"
	if $Panel/ButtonD.button_pressed:
		jawaban = jawaban+"D"
		
	if jawaban == AutoloadSvGlobal.soal[nomor]["jawaban"]:
		bintang+=1
	print(bintang)
	jawaban=""
	
	nomor+=1
	if nomor <= 2:
		setSoal()
	else:
		print("selesai")
		simpanBintang()
	$Panel/ButtonA.set("button_pressed",false)
	$Panel/ButtonB.set("button_pressed",false)
	$Panel/ButtonC.set("button_pressed",false)
	$Panel/ButtonD.set("button_pressed",false)
	
	
	
	
	
	
func mulaiAwal():
	print(nomor)
	setSoal()
	$Panel/AnimationPlayer.play("masuk")

func setSoal():
	$Panel/ScrollContainer/soal.text = AutoloadSvGlobal.soal[nomor]["soal"]
	$Panel/ButtonA.text = AutoloadSvGlobal.soal[nomor]["opsi_a"]
	$Panel/ButtonB.text = AutoloadSvGlobal.soal[nomor]["opsi_b"]
	$Panel/ButtonC.text = AutoloadSvGlobal.soal[nomor]["opsi_c"]
	$Panel/ButtonD.text = AutoloadSvGlobal.soal[nomor]["opsi_d"]
	
	print(AutoloadSvGlobal.soal[nomor])

func _on_btn_selesai_pressed():
	emit_signal("selesaiSoal")
	#$Panel/AnimationPlayer.play("RESET")
	$Panel/AnimationPlayer.play_backwards("selesai popUP")
	await $Panel/AnimationPlayer.animation_finished
	$Panel/AnimationPlayer.play_backwards("masuk")


func setCekboxAllNo():
	$Panel/ButtonA.set("icon",cekbox_no)
	$Panel/ButtonB.set("icon",cekbox_no)
	$Panel/ButtonC.set("icon",cekbox_no)
	$Panel/ButtonD.set("icon",cekbox_no)
	
#stel tampilan tombol

func _on_button_a_toggled(toggled_on):
	if toggled_on :
		$Panel/ButtonA.set("icon",cekbox_ok)
	else :
		$Panel/ButtonA.set("icon",cekbox_no)

func _on_button_b_toggled(toggled_on):
	if toggled_on :
		$Panel/ButtonB.set("icon",cekbox_ok)
	else :
		$Panel/ButtonB.set("icon",cekbox_no)

func _on_button_c_toggled(toggled_on):
	if toggled_on :
		$Panel/ButtonC.set("icon",cekbox_ok)
	else :
		$Panel/ButtonC.set("icon",cekbox_no)

func _on_button_d_toggled(toggled_on):
	if toggled_on :
		$Panel/ButtonD.set("icon",cekbox_ok)
	else :
		$Panel/ButtonD.set("icon",cekbox_no)
