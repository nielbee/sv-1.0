extends Node2D
#@onready var tombol = preload("res://scene/button_stage_dynamic.tscn")
const BUTTON_SIZE = 600

var scroll := 0


func _physics_process(delta):
	$ScrollContainer.set("scroll_horizontal",$ScrollContainer.get("scroll_horizontal") + (60*scroll) )



func getSize():
	return $ScrollContainer.get("size")

func addButton(instancedButton,button_data,button_size):
	#print(button_data)
	#print(button_size)
	$ScrollContainer/HBoxContainer.add_child(instancedButton)
	instancedButton.call("setLabelTombol",button_data.KELAS)
	#print(button_data.POSISI_MAP_VERTIKAL)
	instancedButton.position.x = (int(button_data.POSISI_MAP_VERTIKAL)-1) * BUTTON_SIZE
	var last : Vector2 = $ScrollContainer/HBoxContainer.get("custom_minimum_size")+Vector2(BUTTON_SIZE,0)
	$ScrollContainer/HBoxContainer.set("custom_minimum_size", last)
	$ScrollContainer.set("scroll_horizontal_custom_step", 100)


func scrollKeAkhir():
	var last : Vector2 = $ScrollContainer/HBoxContainer.get("custom_minimum_size")+Vector2(BUTTON_SIZE,0)
	$ScrollContainer/HBoxContainer.set("custom_minimum_size", last)
	


func _on_button_scrollkanan_pressed():
	$ScrollContainer.set("scroll_horizontal",$ScrollContainer.get("scroll_horizontal") + 60 )
func _on_button_scrollkanan_button_down():
	scroll = 1
func _on_button_scrollkanan_button_up():
	scroll = 0


func _on_button_button_down():
	scroll = -1
func _on_button_button_up():
	scroll = 0
