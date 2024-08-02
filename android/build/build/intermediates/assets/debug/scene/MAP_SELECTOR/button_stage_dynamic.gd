extends Node2D

var id
signal load_new
const JARAK_TOMBOL = 5

const list_color = [
	"#8cf0ff",
	"#a09dff",
	"#ff3ff5",
	"#66a5fe",
	"#b0a916",
	"#b00c16",
	"#b00c16",
	"#FF4500",
	"#9ACD32",
	"#7FFF00",
	"#E9967A"
	
]



func _ready():
	_on_button_mouse_exited()
	
func setId(Id):
	id = Id

func setLabelTombol(label):
	$Button.text = label

func getSize():
	return Vector2($Button.get("size").x+JARAK_TOMBOL,$Button.get("size").y+JARAK_TOMBOL)
	#return ($Button.get("size"))
	
func setColor(color_random_index):
	$NinePatchRect.set("modulate",list_color[color_random_index])

func _on_button_pressed():
	if is_instance_valid(AutoloadSvGlobal.materi) : 
		AutoloadSvGlobal.call("bukaMateri")
	$sound.play()
	getStage(id)


func _on_button_mouse_entered():
	pass
	#$NinePatchRect.set("modulate", "#cf0ff")
	

func _on_button_mouse_exited():
	pass
	#$NinePatchRect.set("modulate", "#008a99")


	
func getStage(id_level):
	var data = {
		"id_mapel":id_level,
		"token": AutoloadSvGlobal.token
	}
	AutoloadSvGlobal.makeRequest("https://api.sekolahvirtual.org/getMateri.php",data,AutoloadSvGlobal.ACTION_LIST.SAVE_TO_MATERI)
