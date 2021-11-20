extends Camera2D

export var camX = 0
export var camY = -56
onready var curCamX = camX
onready var curCamY = camY
var camXOff = 24
var camYOff = 8
var offSetSpd = 3

var zoomScale = 1
var zoomMin=1
var zoomMax=1.25
var zoomSpd=.25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass #MoveZoom(delta)
	camOffset(delta)
	position = Vector2(curCamX,curCamY)

func camOffset(delta):
	curCamX = lerp (
		curCamX, 
		camX + (
			int(Input.is_action_pressed("ui_right")) - 
			int(Input.is_action_pressed("ui_left"))) *
			camXOff,delta*offSetSpd)
	curCamY = lerp (
		curCamY, 
		camY + (
			int(Input.is_action_pressed("ui_down")) - 
			int(Input.is_action_pressed("ui_up"))) *
			-camYOff,delta*offSetSpd)

func CheckDirButtons(): #MoveGrid()
	if (Input.is_action_pressed("ui_left")
	or Input.is_action_pressed("ui_right") 
	or Input.is_action_pressed("ui_up")
	or Input.is_action_pressed("ui_down")):
		return true
	else:
		return false

func MoveZoom(delta):
	zoom.x = zoomScale
	zoom.y = zoomScale
	if (CheckDirButtons()):
		zoomScale = lerp(zoomScale,zoomMax,delta*zoomSpd)
	else:
		zoomScale = lerp(zoomScale,zoomMin,delta*zoomSpd)
		pass
