extends RigidBody2D

var should_set_position = false;
var target_position = Vector2(0,0)

func _ready():
	apply_impulse(Vector2.ZERO, Vector2.RIGHT.rotated(deg2rad(rand_range(0.0, 360.0))) * rand_range(50.0, 150.0))
	var rock_scale = Vector2.ONE * rand_range(0.1, 1.0)
	$Rock.scale = rock_scale
	$Shape.scale = rock_scale

func set_physics_position(pos):
	should_set_position = true
	target_position = pos

func _integrate_forces(state):
	if should_set_position:
		state.transform.origin = target_position
		should_set_position = false
		
func _break():
	get_parent().remove_child(self)
	