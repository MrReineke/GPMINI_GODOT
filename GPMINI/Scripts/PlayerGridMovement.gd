extends Node2D

onready var DEBUGTEXT 

const GRIDSIZE = 16
const SNAPSPEED = 10

var PLAYER
onready var CCRC = get_node("collCheckRC") 


var curX
var curY
onready var willCollide = false


func _init():
	#player = get_node("PlayerGrid")
	pass

func _ready():
	if get_node("DEBUGTEXT")!=null:
		DEBUGTEXT=get_node("DEBUGTEXT")
	curX = position.x
	curY = position.y
	#print (curX)
	


func _process(delta):
	willCollide=CCRC.get_overlapping_areas().size()>0
	position.x = lerp(position.x,curX,delta*SNAPSPEED)
	position.y = lerp(position.y,curY,delta*SNAPSPEED)
	print(willCollide)		
	MoveGrid()
		
	
	
func MoveGrid():
	if (Input.is_action_just_pressed("ui_left")):
		checkCollide()
		CCRC.position.y = 0
		CCRC.position.x = -GRIDSIZE
		if !willCollide:
			curX -= GRIDSIZE
			return
	if (Input.is_action_just_pressed("ui_right")):
		checkCollide()
		CCRC.position.y = 0
		CCRC.position.x = +GRIDSIZE
		if !willCollide:
			curX += GRIDSIZE
			return
	if (Input.is_action_just_pressed("ui_up")):
		checkCollide()
		CCRC.position.x = 0
		CCRC.position.y = -GRIDSIZE
		if !willCollide:
			curY -= GRIDSIZE
			return
	if (Input.is_action_just_pressed("ui_down")):
		checkCollide()
		CCRC.position.x = 0
		CCRC.position.y = +GRIDSIZE
		if !willCollide:
			curY += GRIDSIZE
			return

func checkCollide():
	if CCRC.get_overlapping_areas().size()>0:
		#willCollide = true
		return true
	else:
		#willCollide = false
		return false
		
	


func _on_collCheckRC_area_entered(area):
	pass

func _on_collCheckRC_area_exited(area):
	pass
