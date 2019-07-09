extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tool_list : ItemList = $"Control/HBoxContainer/PanelContainer/VBoxContainer/ToolsList"
onready var sample_list : ItemList = $"Control/HBoxContainer/PanelContainer/VBoxContainer/SampleList"
onready var panel : Control = $"Control/HBoxContainer/PanelContainer"

var place_queue = []

export(Array, PackedScene) var tools;
export(Array, PackedScene) var samples;

# Called when the node enters the scene tree for the first time.
func _ready():
	for t in tools:
		t = t.instance()
		tool_list.add_item(t.name, t.icon)
	for s in samples:
		s = s.instance()
		sample_list.add_item(s.name, s.icon)


func add_to_place_queue_from_ui(ui_list : ItemList, list : Array):
	for i in ui_list.get_selected_items():
		i = list[i - 1].instance() # ItemList's seem to start indexing at 1
		place_queue.append(i)

func _on_AddToolButton_pressed():
	add_to_place_queue_from_ui(tool_list, tools)

func _on_AddSampleButton_pressed():
	add_to_place_queue_from_ui(sample_list, samples)

func _input(event):
	if (event is InputEventMouseButton):
		if place_queue.size() > 0 :
			if event.is_pressed():
				var n : Node2D = place_queue[0]
				Input.set_custom_mouse_cursor(n.icon)
				n.position = get_global_mouse_position()
				WorldProperties.sim_path.add_child(n)
				Input.set_custom_mouse_cursor(null)
			else:
				place_queue.pop_front()

func _on_HideButton_pressed():
	panel.visible = !panel.visible

func _on_ClearButton_pressed():
	clear_world()

func clear_world():
	for c in WorldProperties.sim_path.get_children():
		c.queue_free()
	$"RTS-Camera2D".position = Vector2() # Recenter camera
	$"RTS-Camera2D".zoom = Vector2(1, 1) # Reset zoom