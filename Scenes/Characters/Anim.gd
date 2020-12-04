extends Node2D

func play_idle():
	$Idle/AnimationPlayer.play("anim")
	$Idle2.hide()
	$Run.hide()
	$Jump.hide()
func play_idle2():
	$Idle.hide()
	$Idle2/AnimationPlayer.play("anim")
func play_run():
	$Idle.hide()
	$Idle.hide()
	$Run/AnimationPlayer.play("anim")
	$Jump.hide()
func play_jump():
	$Idle.hide()
	$Idle2.hide()
	$Run.hide()
	$Jump/AnimationPlayer.play("anim")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
