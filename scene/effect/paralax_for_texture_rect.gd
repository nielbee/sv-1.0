extends TextureRect

@export var maximum_movement : Vector2 = Vector2.ZERO
@export var movement_step : float = 1.0
@onready var paralax_movement_dir
var CENTER 
var MIN_MOVEMENT
var MAX_MOVEMENT
func texture_get_center_pos():
	return size / 2
	
# Called when the node enters the scene tree for the first time.
func _ready():
	CENTER = texture_get_center_pos()
	print(texture_get_center_pos())
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	paralax_movement_dir = texture_get_center_pos().direction_to(get_global_mouse_position())
	$"..".move_and_collide(paralax_movement_dir*100*delta)
func allowParalax():
	pass
