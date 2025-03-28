extends RigidBody3D

var dropped = false

func _ready():
	pass

func _process(delta):
	if dropped:
		apply_impulse(transform.basis.z,-transform.basis.z*10)
		dropped = false
