extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var punto_final = Vector2(0,0)
var punto_inicial = Vector2(0,0)

var time = 0
var timeDirection = 1
var moveDuration = 2

onready var collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _screenSize = get_viewport().get_visible_rect().size
	punto_final = Vector2(240, 435)
	punto_inicial = Vector2(240, 240)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (time > moveDuration or time < 0):
		timeDirection *= -1
	
	time += delta * timeDirection
	var t = time / moveDuration
	
	self.position = lerp(punto_final, punto_inicial, t)
	
	if abs(position.y - punto_final.y) < 10 :
		collision.disabled = false
	else:
		collision.disabled = true


