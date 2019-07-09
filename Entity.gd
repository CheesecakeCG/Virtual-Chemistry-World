extends KinematicBody2D
class_name Entity

export var description : String
export var icon : Texture

var is_being_dragged : bool = false
var drag_origin : Vector2

func _input(event):
	if (event is InputEventMouseMotion):
		if is_being_dragged:
			_drag_proccess(event)

func _drag_proccess(event : InputEventMouseMotion) -> void:
	var rel : Vector2 = get_global_mouse_position() - global_position
	if not test_move(global_transform, rel):
		global_position = (get_global_mouse_position() + (global_position - drag_origin)) / 2
	else:
		move_and_slide(rel * 4)