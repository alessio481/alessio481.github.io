extends Spatial

var livello = 1
var cubi_usciti = 0
onready var player = $player

func _ready():
	pass

func _on_area_ostacoli_body_exited(body):
	cubi_usciti += 1
	#print(cubi_usciti," cubi usciti")
	body.queue_free()


