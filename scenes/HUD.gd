extends CanvasLayer

onready var pj_seleccionado = 0
onready var variacion_volumen = 0
onready var volumen = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
signal start_game
signal jump_click

onready var puede_cambiar = true

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_gameover():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	
	$Message.text = "Jump!"
	#$Message.show()
	#$JumpMessage.hide()
	$JumpButton.hide()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout() -> void:
	$Message.hide()


func _on_StartButton_pressed() -> void:
	$StartButton.hide()
	#$JumpMessage.show()
	
	emit_signal("start_game")
	$JumpButton.show()


func _on_PauseButton_toggled(button_pressed: bool) -> void:
	if $PauseButton.pressed:
		get_tree().paused = true
	else:
		get_tree().paused = false


func _on_charSelectButtonLeft_pressed() -> void:
	if puede_cambiar:
		if $slime_1.frame <= 2 and $slime_1.frame >= 0:
			$slime_1.frame -= 1
		else:
			$slime_1.frame = 2
		pj_seleccionado = $slime_1.frame


func _on_charSelectButtonRight_pressed() -> void:
	if puede_cambiar:
		if $slime_1.frame <= 2 and $slime_1.frame >= 0:
			$slime_1.frame += 1
		else:
			$slime_1.frame = 0
		pj_seleccionado = $slime_1.frame


func _on_volumeDownButton_pressed() -> void:
	if volumen >= -80:
		volumen = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")) - 10
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),volumen)
	print(volumen)

func _on_volumeUpButton_pressed() -> void:
	if volumen < 0:
		volumen = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")) + 10
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),volumen)


func _on_JumpButton_pressed() -> void:
	emit_signal("jump_click")
