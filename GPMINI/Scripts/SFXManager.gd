extends AudioStreamPlayer


var SFXList = [
	"res://SFX/500900__bertsz__wood-crate-destory-3.wav" #0, Crate Destroy
]

func playSFX(SFX,vol,newPitch):
	stream=load(SFXList[SFX])
	pitch_scale = newPitch
	volume_db = vol
	play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
