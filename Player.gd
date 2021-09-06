extends KinematicBody2D

export (int) var speed = 200

# suaviza control en eje x
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descend : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1.0

var velocity = Vector2.ZERO

var personaje_seleccionado = 0

onready var puede_saltar = false

signal hit

func _on_RopeDetector_area_entered(area: Area2D) -> void:
	if area.name == 'Cuerda':
		emit_signal("hit")

func show_selected_pj():
	if personaje_seleccionado == 1:
		$Sprite.frame = 1
		jump_height = 100
		jump_time_to_peak = 0.3
		jump_time_to_descend = 0.1
	elif personaje_seleccionado == 2:
		$Sprite.frame = 2
		jump_height = 150
		jump_time_to_peak = 0.1
		jump_time_to_descend = 0.3
	else:
		$Sprite.frame = 0
		jump_height = 150
		jump_time_to_peak = 0.3
		jump_time_to_descend = 0.4
		
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1.0


func lose_life():
	pass

func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += 1
	if Input.is_action_pressed("walk_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	if puede_saltar:
		velocity.y = jump_velocity
		$jump_sound.play()

func _physics_process(delta: float) -> void:
	#get_input()
	show_selected_pj()
	velocity.y += get_gravity() * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()








func _on_HUD_jump_click() -> void:
	if is_on_floor():
		jump()
