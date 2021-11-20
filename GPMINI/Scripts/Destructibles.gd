extends Area2D

export var particFX = ""


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	var scene = load("res://Prefabs/ParticFX/pfx_CratePlanks.tscn") #load(particFX)
	#print(scene)
	
	gm.slowDown(.2,.04)
	
	var scene_instance = scene.instance()
	scene_instance.set_name("scene")
	get_parent().add_child(scene_instance)
	scene_instance.position = position
	queue_free()
	pass # Replace with function body.
