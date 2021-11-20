extends Area2D
#extends KinematicBody2D

#############
#Input.start_joy_vibration(0,1,.0,.05)
#############

#var isFlying = false
#var flyingBack = false
var pTimer = 1 #punchTimer
var yPos = 0
var FLYSPEED = 2

var dist = 0
var minDist = 40
var maxDist = 136
var distCharge = 48 #how quickly the distance increase charges up

onready var collShort = $CollShort
onready var coll = $Coll
onready var anim = $AnimationPlayer
export(Curve) var punchCurve
var punchCurveOutput

onready var retic = $Retic

func _ready():
	dist = minDist

func punchPressed():
	return (name=="FistRgt" && Input.is_action_pressed("punch_rgt"))||(name=="FistLft"&&Input.is_action_pressed("punch_lft"))

func punchJustReleased():
	return (name=="FistRgt" && Input.is_action_just_released("punch_rgt"))||(name=="FistLft"&&Input.is_action_just_released("punch_lft"))
	if pTimer <=1: 
		dist = minDist

func punch(delta):
	#Throwing a punch
	if punchJustReleased():
		#anim.play("anim_punch")
		anim.stop()
		$FistSpr.frame=0
		Input.start_joy_vibration(0,0,dist/maxDist,.15)
		pTimer=0
	
	#playing "animation"
	if pTimer<=1:
		pTimer+=delta*FLYSPEED
	else:
		pass
		
	
	#charging distance
	if punchPressed():
		anim.play("anim_spinCharge") 
		Input.start_joy_vibration(0,dist/maxDist/2,0,.1)
		
		#sfx charge
		dist+=delta*distCharge
		dist=clamp(dist,minDist,maxDist)
		
	#resetting distance
	if pTimer>1&&!punchPressed():
		dist=minDist
		
	#Activate collision
	if pTimer<=0.8:
		coll.disabled=false
	else:
		coll.disabled=true
		
		
	
	#Evaluating curve
	punchCurveOutput = punchCurve.interpolate(pTimer)
	position.y = -punchCurveOutput*dist

func _physics_process(delta):
	retic.position.y=-dist
	retic.visible=pTimer>1
	punch(delta)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#if (((Input.is_action_just_released("punch_lft") && name=="FistLft")
	#||(Input.is_action_just_released("punch_rgt") && name=="FistRgt"))
	#&& !isFlying && !flyingBack):
		
		#$FistSpr.modulate = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1))
		
		#shortPunch()
		####anim.stop()
		####anim.play("anim_jab")
		#isFlying = true

#func shortPunch() -> void:
#	collShort.disabled = false
#	yield(get_tree().create_timer(.2),"timeout") #Will later be replaced by animation timer?
#	#SFX
#	collShort.disabled = true



#func _physics_process(delta):
#	if (isFlying):
#		fistFly(delta)
#	if (flyingBack):
#		fistFlyBack(delta)
#	var collInfo = move_and_collide(Vector2.ZERO)
#	if collInfo:
#		pass
##func _on_body_entered(body: PhysicsBody2D) -> void:
##	if body.get_collision_layer_bit(0):
##		print (name + " hit solid...")
#
#func fistFly(delta):
#
#	#if $Collision.
#
#	if time>0:
#		time-=delta*FLYSPEED
#		yPos = MAXDIST*(time-1) #yPos = sin(1-time/2*FLYSPEED)*MAXDIST
#		position = Vector2 (position.x,yPos)
#	else:
#		flyingBack = true
#		isFlying = false
#
#
#func fistFlyBack(delta):
#	if yPos<0:
#		#print ("FLYING BACK")
#		#print (yPos)
#		yPos+=delta*FLYSPEED*MAXDIST #probably not the best way to do this...
#		position = Vector2 (position.x,yPos)
#	else:
#		position = Vector2 (position.x,0)
#		flyingBack=false


