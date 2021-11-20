extends AudioStreamPlayer2D

export var minPitch = 0.6
export var maxPitch = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pitch_scale=rand_range(minPitch,maxPitch)
