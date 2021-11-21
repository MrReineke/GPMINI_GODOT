extends Node

enum state {
	default,
	dash
}
var curState



func _ready():
	
	pass # Replace with function body.

func slowDown(spd,t):
	Engine.time_scale = spd
	yield(get_tree().create_timer(t), "timeout")
	Engine.time_scale = 1
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
