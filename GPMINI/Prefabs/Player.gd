extends KinematicBody2D



export var MAX_SPEED = 120
var SPEED = 50
var ACC = 4
var motion = Vector2.ZERO
var axis

var dashDur = .12 #Dash Duration
var dashSpd = 3
var dashTimer
var dashTimerMax = .5
var pfxDash

func _ready():
	dashTimer=dashTimerMax
	gm.curState = gm.state.default
	pfxDash = preload("res://Prefabs/ParticFX/pfx_Dash.tscn")
	pass

func _physics_process(delta):
	
	CheckDirButtons()
	if dashTimer<dashTimerMax:
		dashTimer+=delta
	
	if gm.curState==gm.state.dash:
		Dashing(axis) #WONT WORK BECAUSE THIS WILL UPDATE DURING THE STATE
	
	if gm.curState==gm.state.default:
		
		if Input.is_action_just_pressed("dash")&&motion!=Vector2.ZERO&&dashTimer>=dashTimerMax:
			dashTimer=0
			SPEED=MAX_SPEED
			pfxDashSpawn()
			gm.curState = gm.state.dash
			axis = get_input_axis()
		
		axis = get_input_axis()
		motion = move_and_slide(get_input_axis()*SPEED)
		if CheckDirButtons():
			SPEED = lerp(SPEED,MAX_SPEED, delta*ACC )
		else:
			SPEED = lerp(SPEED,MAX_SPEED*.1, delta*ACC*10)
	
func pfxDashSpawn():
	var pfxDash_instance = pfxDash.instance()
	pfxDash_instance.position = position
	pfxDash_instance.set_name("newPFXDash")
	get_parent().add_child(pfxDash_instance)

func CheckDirButtons(): #MoveGrid()
	if (Input.is_action_pressed("ui_left")
	or Input.is_action_pressed("ui_right") 
	or Input.is_action_pressed("ui_up")
	or Input.is_action_pressed("ui_down")):
		return true
	else:
		return false
		#SPEED = lerp(SPEED,MAX_SPEED, delta*10 )
		#return#move_and_slide_with_snap(get_input_axis().x,get_input_axis().y)

func Dashing(dir):
	motion = move_and_slide(dir*SPEED*dashSpd)
	#ADDFORCE IN DIRECTION
	yield(get_tree().create_timer(dashDur),"timeout")
	gm.curState = gm.state.default
	pass

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion-=motion.normalized() * amount
	else:
		motion = Vector2.ZERO


