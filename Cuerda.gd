extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
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
