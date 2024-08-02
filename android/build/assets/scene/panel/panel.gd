extends Panel

var saveToken = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequestuserInfo.request(SVGlobalVariable.getUserInfolink())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func registerJikaBelumAdaAkun(email,username,password):
	#register dolo
	var data = {
		"email":email,
		"password": password,
		"nama": username
	}
	$HTTPRequestGetToken.request("https://api.sekolahvirtual.org/registrasi.php",[],HTTPClient.METHOD_POST,JSON.stringify(data))
	await $HTTPRequestGetToken.request_completed
	saveToken = true
	#abis itu ambil token
	data = {
		"email":email,
		"password":password
	}
	
	$HTTPRequestGetToken.request("https://api.sekolahvirtual.org/login.php",[],HTTPClient.METHOD_POST,JSON.stringify(data))
	


func _on_http_requestuser_info_request_completed(result, response_code, headers, body):
	var Body = JSON.parse_string(body.get_string_from_utf8())
	print(Body)
	registerJikaBelumAdaAkun(Body.email,Body.name,Body.id)
	$LabelNama.text = Body.name
	#Body = null


func _on_http_request_get_token_request_completed(result, response_code, headers, body):
	var Body = JSON.parse_string(body.get_string_from_utf8())
	#print(Body)
	if saveToken == true:
		AutoloadSvGlobal.token = Body.token
		print(AutoloadSvGlobal.token)
		saveToken = null
