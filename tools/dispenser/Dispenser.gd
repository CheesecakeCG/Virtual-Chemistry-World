extends Tool

export(Array, PackedScene) var samples;
onready var sample_list : OptionButton = $"ControlRoot/ActionBox/SampleChooserButton"
onready var timer : Timer = $"Timer"

var is_on : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for s in samples:
		s = s.instance()
		sample_list.add_item(s.name)

func _on_Timer_timeout():
	dispence()

func dispence():
	var s : KinematicBody2D = samples[sample_list.selected].instance()
	s.global_position = global_position
	WorldProperties.sim_path.add_child(s)

func _on_PowerButton_toggled(button_pressed):
	is_on = button_pressed
	if is_on:
		timer.start()
	else:
		timer.stop()
