extends Entity

enum STATES { solid, liquid, gas, plasma }

# Per Type Properties
export var boiling_point : float
export var freezing_point : float
export var mass : float
export var volume : float

# Per instance properties
var temperature : float
var state : int = STATES.solid
onready var density : float = mass / volume

var velocity : Vector2

func _ready():
	randomize()

func _process(delta : float):
	# Cool down to ambient temperature
	temperature = (temperature + WorldProperties.ambient_tempurature) / 2
	# Change state based on temperature, run the appropriate do-loops for each state
	if temperature > boiling_point:
		state = STATES.gas
	else:
		if temperature > freezing_point:
			state = STATES.liquid
		else:
			state = STATES.solid
	match state:
		STATES.solid:
			pass
		STATES.liquid:
			_fluid_process(delta)
		STATES.gas:
			_fluid_process(delta)

	# Apply boyancy
	# W = pgV
	velocity += WorldProperties.ambient_air_density * WorldProperties.gravity * volume * delta

	# Apply gravity
	velocity += WorldProperties.gravity * delta

	move_and_slide(velocity)

func _fluid_process(delta : float):
	velocity = 2 * delta * (temperature + 270) * Vector2(2 * randf() - 1, 2 * randf() - 1) * (1/mass)
