extends RigidBody2D

var should_set_position = false;
var target_position = Vector2(0,0)

var randomize_rock = true
var rock_scale = Vector2.ONE;
var rock_rotation = 0.0
var initial_impulse = Vector2.ZERO;

var was_emitting = false

func _ready():
	if randomize_rock:
		rock_scale = Vector2.ONE * rand_range(0.1, 1.0)
		initial_impulse = Vector2.RIGHT.rotated(deg2rad(rand_range(0.0, 360.0))) * rand_range(50.0, 150.0);
	rock_rotation = rand_range(0.0, 2.0 * PI);
	apply_torque_impulse(rand_range(0.1, 0.5))
	$Rock.scale = rock_scale
	$Shape.scale = rock_scale
	$Rock.rotation = rock_rotation;
	$Shape.rotation = rock_rotation;
	apply_impulse(Vector2.ZERO, initial_impulse);

func _fixed_process(dt):
	if was_emitting && !$BreakParticles.emitting:
		$SelfDestroy.mark_destroy();

func set_physics_position(pos):
	should_set_position = true
	target_position = pos

func _integrate_forces(state):
	if should_set_position:
		state.transform.origin = target_position
		should_set_position = false
		
func _break():
	call_deferred("_visual_break")
	if rock_scale.length() > 0.25:
		call_deferred("_split_rocks")
	
func _visual_break():
	$Shape.disabled = true;
	$Rock.visible = false;
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	was_emitting = true;
	$BreakParticles.process_material.scale = rock_scale.x * 8.0
	$BreakParticles.process_material.initial_velocity = rock_scale.x * 250.0
	$BreakParticles.emitting = true;
	
func _split_rocks():
	var rock = load("res://Scenes/SpaceRock.tscn");
	for i in range(4):
		var instance = rock.instance();
		instance.position = position + Vector2(-32.0 + (64.0 * (i % 2)), -32.0 + (64.0 * clamp((i % 3), 0, 1))).rotated(rotation) * rock_scale;
		var impulse_dir = instance.position - position
		instance.initial_impulse = impulse_dir.normalized() * rand_range(50.0, 150.0)
		instance.randomize_rock = false
		instance.rock_scale = rock_scale * 0.5
		get_parent().add_child(instance)
