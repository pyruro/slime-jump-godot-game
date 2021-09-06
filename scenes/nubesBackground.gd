extends CanvasLayer


func _physics_process(delta):
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= 0.08
