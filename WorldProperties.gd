extends Node

var ambient_tempurature : float = 23
var ambient_air_density : float = 1.225 # kg/m³
var gravity : Vector2 = Vector2(0, -9.81)

onready var sim_path : Node = $"/root/Root/Sim"