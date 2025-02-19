extends Node2D

var score
var difficulty_timer = 0
var increase_diff = 0
var seconds = 0

onready var random_value_1 = rand_range(1.5,3.5)
onready var random_value_2 = rand_range(1.5,2.5)
onready var random_value_3 = rand_range(2.5,3.5)

onready var playing = false

func gameover():
	$ScoreTimer.stop()
	$Cuerda/AnimatedSprite.frame = 0
	$Cuerda/CollisionShape2D.disabled = true
	$Cuerda/AnimatedSprite.playing = false
	$Cuerda.ciclo_salto = 0
	$HUD.show_gameover()
	playing = false
	$Player.puede_saltar = playing
	$HUD.puede_cambiar = true
	
func new_game(): # se lanza al pulsar el botón de inicio
	score = 0
	randomize()
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(2), "timeout")
	playing = true
	$Player.puede_saltar = playing
	$HUD.puede_cambiar = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass

func manage_difficulty(delta):
	if $Cuerda.ciclo_salto > 1 and $Cuerda.ciclo_salto < 25:
		$Cuerda/AnimatedSprite.speed_scale += delta/40
	elif $Cuerda.ciclo_salto >= 25 and $Cuerda.ciclo_salto < 35:
		$Cuerda/AnimatedSprite.speed_scale = 2
	elif $Cuerda.ciclo_salto >= 35 and $Cuerda.ciclo_salto < 45:
		$Cuerda/AnimatedSprite.speed_scale = 1.5
	elif $Cuerda.ciclo_salto >= 45 and $Cuerda.ciclo_salto < 75:
		$Cuerda/AnimatedSprite.speed_scale = 2.5
	elif $Cuerda.ciclo_salto >= 75 and $Cuerda.ciclo_salto < 80:
		$Cuerda/AnimatedSprite.speed_scale = random_value_1
	elif $Cuerda.ciclo_salto >= 80 and $Cuerda.ciclo_salto < 95:
		$Cuerda/AnimatedSprite.speed_scale = random_value_2
	elif $Cuerda.ciclo_salto >= 95 and $Cuerda.ciclo_salto < 110:
		$Cuerda/AnimatedSprite.speed_scale = random_value_3
	elif $Cuerda.ciclo_salto >= 110:
		if $Cuerda/AnimatedSprite.speed_scale < 5:
			$Cuerda/AnimatedSprite.speed_scale += delta/40
		else:
			$Cuerda/AnimatedSprite.speed_scale = 5
	else:
		$Cuerda/AnimatedSprite.speed_scale = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	manage_difficulty(delta)
	$Player.personaje_seleccionado = $HUD.pj_seleccionado
	#print($Cuerda/AnimatedSprite.speed_scale)
	#difficulty_timer += delta
	#seconds = difficulty_timer / 5
	
	#increase_diff = float(round(difficulty_timer))/10.0
	#print(increase_diff)

func _on_StartTimer_timeout() -> void:
	$ScoreTimer.start()
	$Cuerda/AnimatedSprite.play()
	
func _on_ScoreTimer_timeout() -> void:
	score += 1
	$HUD.update_score(score)



func _on_Player_hit() -> void:
	gameover()
