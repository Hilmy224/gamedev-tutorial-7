extends Interactable

@export var light : NodePath
@export var on_by_default = true
@export var energy_when_on = 10
@export var energy_when_off = 3

@onready var light_node : Light3D = get_node(light)
@onready var button_mesh : MeshInstance3D = $Switch  # Assumes you have a child MeshInstance3D

var on = on_by_default

func _ready():
	light_node.light_energy = energy_when_on if on else energy_when_off

func interact():
	on = !on
	light_node.light_energy = energy_when_on if on else energy_when_off
	
	if on:
		button_mesh.position = Vector3(0, 0, 0.2)
	else:
		button_mesh.position = Vector3(0, 0, 0)
