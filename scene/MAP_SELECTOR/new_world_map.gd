extends Node2D
@onready var tombol = preload("res://scene/MAP_SELECTOR/button_stage_dynamic.tscn")
@onready var DynamicHBox = preload("res://scene/MAP_SELECTOR/dynamic_hbox.tscn")
@onready var data
var jumlah_data_vertikal = 0
const map_url = "https://apiadmin.sekolahvirtual.org/semua_jenjang_mapel.php"
const JARAK_TOMBOL = 4
var instancedHorizontal : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request(map_url,[],HTTPClient.METHOD_POST,"")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_http_request_request_completed(result, response_code, headers, body):
	data = JSON.parse_string(body.get_string_from_utf8())
	#print(data)
	#cek jumlah data vertikal1, nanti dibuat container sendiri
	for d in data:
		if int(d.POSISI_MAP_HORIZONTAL) > jumlah_data_vertikal :
			jumlah_data_vertikal = int(d.POSISI_MAP_HORIZONTAL)
	
	
	for n in jumlah_data_vertikal:
	# buat dynamic vertikal, kenapa salah nama jadi hbox?? 
		var turun_ke_bawah_baru = DynamicHBox.instantiate()
		#print("buat baru ke "+ var_to_str(n))
		$map/ScrollContainer/vertikalScroll.add_child(turun_ke_bawah_baru)
		turun_ke_bawah_baru.position.y = n*turun_ke_bawah_baru.call("getSize").y
		#ada 10 index di list_colot tombol stage dynamic
		var temp_color = null
		var color_rand = randi_range(0,10)
		if temp_color == color_rand:
			color_rand = randi_range(0,10)
		#$map/ScrollContainer/vertikalScroll.set("custom_minimum_size",n*turun_ke_bawah_baru.call("getSize").y)
		for d in data : 
			if int(d.POSISI_MAP_HORIZONTAL) == n+1 :
				var tombol_ke_kanan = tombol.instantiate()
				turun_ke_bawah_baru.call("addButton",tombol_ke_kanan,d,turun_ke_bawah_baru.call("getSize"))
				#turun_ke_bawah_baru.call("setId",)
				tombol_ke_kanan.call("setId",d.ID)
				tombol_ke_kanan.call("setColor",color_rand)

				#ini su sort di horizontal, jang buat kaco ini, tinggal add_child di vertikal su
		temp_color = color_rand
