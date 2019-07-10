extends Node

var ambient_tempurature : float = 23
var ambient_air_density : float = 1.2 # kg/m³???
var gravity : Vector2 = Vector2(0, -9.81)

var enable_particle_collisions : bool = true

onready var sim_path : Node = $"/root/Root/Sim"