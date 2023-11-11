extends RigidBody

onready var mesh = $MeshInstance
onready var collisione = $CollisionShape
var grandezza_max = 7
var grandezza_min = 4
var rotazione_max = 14


func _ready():
	mesh.scale.x = rand(grandezza_min,grandezza_max)
	mesh.scale.y = rand(grandezza_min,grandezza_max)
	mesh.scale.z = rand(grandezza_min,grandezza_max)
	collisione.scale = mesh.scale
	apply_torque_impulse(Vector3(rand(0,rotazione_max),rand(0,rotazione_max),rand(0,rotazione_max)))

func rand(num1,num2):
	randomize()
	var random = rand_range(num1,num2)
	return(random)





func _on_Timer_timeout():
	queue_free()
