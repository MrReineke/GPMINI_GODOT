extends Particles2D

onready var SFX = $SFX

func _ready():
	emitting=true
	

func _process(delta):
	
	if amount==0:#if !emitting:
		queue_free()
		
