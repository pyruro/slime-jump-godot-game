extends Node2D

var score
var difficulty_timer = 0
var increase_diff = 0

func gameover():
	$ScoreTimer.stop()
	$HUD.show_gameover()
func new_game(): # se lanza al pulsar el botón de inicio
	score = 0
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#difficulty_timer += delta
	#increase_diff = float(round(difficulty_timer))/10.0
	#print(increase_diff)

func _on_StartTimer_timeout() -> void:
	$ScoreTimer.start()
	$Cuerda/AnimatedSprite.play()
	
func _on_ScoreTimer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

