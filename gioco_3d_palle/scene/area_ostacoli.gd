extends Spatial


onready var ostacolo = preload("res://scene/ostacolo.tscn")
var random_range = 100
func _ready():
	pass


func rand(num1,num2):
	randomize()
	var random = rand_range(num1,num2)
	return(random)


func _on_player_elimina_cubi():
	for i in get_children():
		if i.get_class() == "RigidBody":
			i.queue_free()


func _on_player_genera_cubi(gen_z,x,y):

	for _j in range(110):
		var caca = ostacolo.instance()
		add_child(caca)
		caca.translation.z = -gen_z.z #+ 360
		caca.translation.y = -rand(y-random_range,y+random_range)#rand(-24,25)
		caca.translation.x = rand(x-random_range,x+random_range)#rand(-38,38)
		
		
		
