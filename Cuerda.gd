extends Area2D


var ciclo_salto = 0

func _ready() -> void:
	$CollisionShape2D.disabled = true
	#position = Vector2(240, 450)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.frame in range(9,10):
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
	if $AnimatedSprite.frame in range(4, 10):
		z_index = 1
	else:
		z_index = 0
	if $AnimatedSprite.frame == 9:
		ciclo_salto += 1
