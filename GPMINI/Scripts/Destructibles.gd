extends Area2D

export var particFX = ""
export var SFX = 0
var SFXM #sfx manager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if get_node("../../SFXManager") != null:
		SFXM=get_node("../../SFXManager") 
			
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	
	gm.slowDown(.2,.04)
	SFXM.playSFX(SFX,-5,rand_range(.8,1.2))
	var scene = load("res://Prefabs/ParticFX/pfx_CratePlanks.tscn") #load(particFX)
	var scene_instance = scene.instance()
	scene_instance.set_name("scene")
	get_parent().add_child(scene_instance)
	scene_instance.position = position
	queue_free()
	pass # Replace with function body.
