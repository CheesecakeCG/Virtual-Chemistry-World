extends Entity

enum STATES { solid, liquid, gas }

# Per Type Properties
export var boiling_point : float
export var freezing_point : float
export var mass : float
export var volume : float
export var conductivity : float

# Per instance properties
var temperature : float
var state : int = STATES.solid

onready var density : float = mass / volume
onready var CHARLES_CONST : float = volume / (temperature + 270)

var velocity : Vector2

func _ready():
	randomize()

func _process(delta : float):
		# Cool down to ambient temperature
	apply_temp(WorldProperties.ambient_tempurature, delta)

	# Apply Charles' Law
	volume = CHARLES_CONST * temperature

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
			_fluid_process(delta, true)
		STATES.gas:
			_fluid_process(delta, false)

	# Apply boyancy
	# W = pgV
	velocity += WorldProperties.ambient_air_density * WorldProperties.gravity * volume * delta

	# Apply gravity
	velocity += WorldProperties.gravity * delta

	# Apply volume visually
	$Sprite.scale = Vector2(1, 1) * clamp(inverse_lerp(.1, 20, volume), .2, 1)
#	$Sprite.modulate.a = lerp(.3, .8, inverse_lerp(20, .01, volume))

func _fluid_process(delta : float, should_collide : bool):
	# Brownian Motion
#	velocity = (delta * (temperature + 270) * Vector2(2 * randf() - 1, 2 * randf() - 1))

	# Only gases are allowed to collide since they do it less often, collisions are slow
	if (should_collide):
		move_and_slide(velocity)
	else:
		position += velocity

func apply_temp(t : float, delta : float) :
#	$Tween.remove_all()
#	$Tween.interpolate_property(self, "temperature", temperature, t, 1 / conductivity, $Tween.TRANS_EXPO, $Tween.EASE_IN)
#	$Tween.start()
	temperature = lerp(temperature, t, ease(delta * conductivity, .8))