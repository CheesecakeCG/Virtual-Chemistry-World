extends Tool

export var max_temperature : float
export var min_temperature : float

var temperature : float
var is_on : bool = false

onready var heat_area = $"HeatArea"
onready var temp_spinner = $"ControlRoot/ActionBox/TempSpinner"

func _ready():
	temp_spinner.max_value = max_temperature
	temp_spinner.min_value = min_temperature
	temp_spinner.value = max_temperature

func _process(delta):
	if is_on:
		for b in heat_area.get_overlapping_bodies():
			if b.is_in_group("element"):
				b.temperature = (b.temperature + temperature) / 2

func _on_Temp_value_changed(value):
	temperature = value

func _on_PowerButton_toggled(button_pressed):
	is_on = button_pressed
