extends KinematicBody

var dir = Vector3()
var velocity = Vector3.ZERO
var speed = 60
var accell = 80
var gravita = 1300
var vivo = true
var tempo_trascorso = 0
var guadagno_gravita = 0.1
onready var gen_z = global_translation - Vector3(0,0,30)
onready var posizione_iniziale = translation
onready var tween = $Tween
onready var ostacolo = preload("res://scene/ostacolo.tscn")
onready var particelle = $mesh_particelle/CPUParticles
onready var HUD_lable = $CanvasLayer/HUD/Label

signal elimina_cubi
signal genera_cubi(num,x,y)


func _ready():
	pass 

# se si allontana troppo dalla y o x da cui è iniziata la gen allora fanne un'altra
func _physics_process(delta):
	#gravita = gravita + tempo_trascorso * guadagno_gravita
	if global_translation.z <= gen_z.z:
		gen_z = global_translation - Vector3(0,0,30)
		emit_signal("genera_cubi",gen_z,global_translation.x,global_translation.y)

	
	dir = Vector3.ZERO
	dir.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	dir.y = (Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")) 
	particelle.direction = lerp(particelle.direction,-dir,0.04)
	if not dir:
		particelle.emitting = false
	else:
		particelle.emitting = true
	dir *= speed
	velocity = velocity.move_toward(dir,accell*delta)
	
	velocity.z = -gravita * delta
	move_and_slide(velocity,Vector3(0,0,0),false,4,0.785,false)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.get_class() == "RigidBody"  and vivo:
			morto()
			var mesh = collision.collider.get_child(0)
			var new_material = mesh.get_surface_material(0).duplicate()
			new_material.albedo_color = Color(1, 0, 0)
			mesh.set_surface_material(0, new_material)
			
		elif collision.collider.is_in_group("fine") and vivo:
			vittoria()


func morto():
	speed = 0
	gravita = 0
	
	print("sei morto")
	vivo = false
	$Timer_respawn.start()


func rand(num1,num2):
	randomize()
	var random = rand_range(num1,num2)
	return(random)


func vittoria():
	speed = 0
	gravita = 0
	vivo = false
	$Timer_respawn.start()


func tween_finito():
	print("tween finito")


func _on_Timer_respawn_timeout():
	emit_signal("elimina_cubi")
	tempo_trascorso = 0
	gen_z.z = -30
	vivo = true
	global_translation = Vector3(0,0,-12)
	speed = 100
	gravita = 1300


func _on_Timer_velocita_timeout():
	gravita += 10
	tempo_trascorso += 1
	HUD_lable.text = str(tempo_trascorso)
