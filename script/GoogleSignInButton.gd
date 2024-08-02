extends Button
const linkgetUserInfo = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json&access_token="
signal loginBerhasil
signal loginGagal
var userData


func _ready():
	Firebase.Auth.login_succeeded.connect(login_sukses)
	Firebase.Auth.login_failed.connect(login_gagal)
	

func _on_pressed():
	#yang lama
	var provider : AuthProvider = Firebase.Auth.get_GoogleProvider()
	Firebase.Auth.get_auth_localhost(provider,8060)
	
	


func login_sukses(Auth):
	Firebase.Auth.save_auth(Auth)
	SVGlobalVariable.setUserInfolink(linkgetUserInfo+Auth.accesstoken)
	emit_signal("loginBerhasil")

	
func login_gagal():
	emit_signal("loginGagal")
	
