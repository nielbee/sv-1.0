extends Node2D
signal get_materi
signal buka_container_deskripsi
signal tutup_container_deskrisi
signal get_soal

var soal : Array
var action : int
var token 
var materi : Array
enum ACTION_LIST {
	SAVE_TO_SOAL,
	SAVE_TO_TOKEN,
	SAVE_TO_MATERI
}


func saveSoal(dictSoal):
	soal = dictSoal
	print(soal)


func makeRequest(link,data,_action):
	print("ini aksi "+ var_to_str(_action))
	action = _action
	$HTTPRequest.request(link,[],HTTPClient.METHOD_POST,JSON.stringify(data))
	await $HTTPRequest.request_completed

func _on_http_request_request_completed(result, response_code, headers, body):
	print("ini dari global :")
	print(body.get_string_from_utf8())
	if action == ACTION_LIST.SAVE_TO_SOAL:
		soal = JSON.parse_string(body.get_string_from_utf8())
		emit_signal("get_soal")
	elif action == ACTION_LIST.SAVE_TO_TOKEN:
		token = JSON.parse_string(body.get_string_from_utf8())
	elif action == ACTION_LIST.SAVE_TO_MATERI:
		materi = JSON.parse_string(body.get_string_from_utf8())
		emit_signal("get_materi")
func bukaMateri():
	emit_signal("buka_container_deskripsi")
	
