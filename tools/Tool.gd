extends Entity
class_name Tool

onready var action_box = $"ControlRoot/ActionBox"

# Called when the node enters the scene tree for the first time.
func _ready():
	action_box.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_HoverArea_mouse_entered():
	action_box.show()

func _on_HoverArea_mouse_exited():
	action_box.hide()


func _on_HoverArea_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if (event.is_pressed() && event.button_index == BUTTON_LEFT):
			is_being_dragged = true
		else:
			is_being_dragged = false

func _drag_proccess(event : InputEventMouseMotion) -> void:
	._drag_proccess(event)
	update_ui_position()

func update_ui_position() -> void:
	$"ControlRoot".rect_global_position = global_position

func _on_DeleteButton_pressed():
	hide()
	queue_free()
