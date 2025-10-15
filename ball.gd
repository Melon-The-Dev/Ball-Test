extends Area2D


var SPEED = 100.0
const EDGE_OFFSET = 50.0


var velocity: Vector2 = Vector2.ZERO
var r = 0.0

func _physics_process(delta: float):
	position += velocity * delta
	rotation_degrees +=  (((velocity.x+velocity.y)/5)*delta)*r

func _ready():
	$Ballimg.modulate = generate_random_color()
	var rscale = randf_range(0.5,1.5)
	scale = Vector2(rscale, rscale)
	spawn_off_screen()
	r = randi_range(-1,1)

func spawn_off_screen():
	var viewport_size = get_viewport_rect().size
	var side = randi() % 4
	var center_target = viewport_size / 2
	var random_variance = Vector2(
		randf_range(-center_target.x / 3, center_target.x / 3),
		randf_range(-center_target.y / 3, center_target.y / 3)
	)
	var target_position = center_target + random_variance
	match side:
		0:
			position.x = randf_range(0, viewport_size.x)
			position.y = -EDGE_OFFSET
		1:
			position.x = randf_range(0, viewport_size.x)
			position.y = viewport_size.y + EDGE_OFFSET
		2:
			position.x = -EDGE_OFFSET
			position.y = randf_range(0, viewport_size.y)
		3:
			position.x = viewport_size.x + EDGE_OFFSET
			position.y = randf_range(0, viewport_size.y)

	var direction_vector = target_position - position
	var direction_normalized = direction_vector.normalized()
	velocity = direction_normalized * SPEED
	print("Spawned at: ", position, " | Target: ", target_position)
	print("Direction Vector: ", direction_normalized)


func generate_random_color() -> Color:
	var r = randf()
	var g = randf()
	var b = randf()
	var a = 1.0
	return Color(r, g, b, a)


func _on_mouse_entered() -> void:
	get_tree().current_scene.game_over()
