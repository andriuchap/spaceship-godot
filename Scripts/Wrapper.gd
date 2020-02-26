extends Node

export var wrap_distance = 64

var screen_size;

var is_physics = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size;
	if get_parent() is RigidBody2D:
		is_physics = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# the offset of the node from the screen's origin
	var root_pos = get_parent().position;

	root_pos.x = wrapf(root_pos.x, -wrap_distance, screen_size.x + wrap_distance);
	root_pos.y = wrapf(root_pos.y, -wrap_distance, screen_size.y + wrap_distance);

	if is_physics:
		get_parent().set_physics_position(root_pos);
	else:
		get_parent().position = root_pos;
