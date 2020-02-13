extends Node

export var wrap_distance = 64

var screen_size;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# the offset of the node from the screen's origin
	var root_pos = get_parent().position;
	
	root_pos.x = wrapf(root_pos.x, -wrap_distance, screen_size.x + wrap_distance);
	root_pos.y = wrapf(root_pos.y, -wrap_distance, screen_size.y + wrap_distance);
	
	get_parent().position = root_pos;
	
	print(get_parent().get_name())
