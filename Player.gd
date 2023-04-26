extends CharacterBody2D

var Speed = 300.0
const JUMP_VELOCITY = -450.0
var Dash = false
var Cd = true
var Gravity = 1750

func _ready():
	$Animaciones.play("Idle")
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		if Input.is_action_pressed("Space") and velocity.y > 0:
			velocity.y = 80
		velocity.y += Gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Animaciones.play("Jump")
	salto_potenciado()
	mov_lateral()
	animacion_idle()
	dash()
	move_and_slide()
	pass

func salto_potenciado():
	if Input.is_action_just_pressed("q") and is_on_floor():
		velocity.y = JUMP_VELOCITY * 2.5
		$Animaciones.play("Jump")
	pass

func dash():
	if Input.is_action_just_pressed("e") and is_on_floor():
		Dash = true
		$DashTime.start()
		Speed = 1200
	pass

func mov_lateral():
	
	if Input.is_action_pressed("ui_right"):
		if is_on_floor():
			$Animaciones.play("Run")
			$Animaciones.flip_h = false
		else:
			$Animaciones.flip_h = false
		velocity.x = 1 * Speed 
		
	elif Input.is_action_pressed("ui_left"):
		if is_on_floor():
			$Animaciones.play("Run")
			$Animaciones.flip_h = true
		else:
			$Animaciones.flip_h = true
		velocity.x = -1 * Speed
	
	elif Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"): 
		velocity.x = 0
	pass
	
func animacion_idle():
	if velocity.y == 0 and velocity.x == 0:
		$Animaciones.play("Idle")
	pass
	
func _on_dash_time_timeout():
	Speed = 300
	pass 


