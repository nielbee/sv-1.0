extends Button



@onready var default_button_size = $".".get("scale")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_mouse_entered():
	$".".set("scale", default_button_size*1.2)



func _on_mouse_exited():
	$".".set("scale", default_button_size)
