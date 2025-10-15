extends Node2D

const BALL = preload("uid://neafyrt5gjco")
@onready var gover: Control = $CanvasLayer/gover
@onready var score_lbl: Label = $CanvasLayer/score

var score = 0
var bspeed = 100

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _process(delta: float) -> void:
	score_lbl.text = "Score: " + str(score)
	if $CanvasLayer/gover.visible and Input.is_action_just_pressed("rmb"):
		get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	score += 1
	spawn_ball()
	spawn_ball()

func spawn_ball():
	var b = BALL.instantiate()
	b.SPEED = bspeed
	b.position = Vector2(-100, -100)
	$balls.add_child(b)


func _on_speedup_timeout() -> void:
	bspeed += 15
	$Timer.wait_time -= 0.05
	$Timer.wait_time = clamp($Timer.wait_time,0.1,1)

func game_over():
	for balls in $balls.get_children():
		balls.queue_free()
	$Timer.stop()
	$speedup.stop()
	gover.show()
