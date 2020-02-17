extends Node

var pending_destroy = false;

func _process(delta):
	if pending_destroy:
		get_parent().get_parent().remove_child(get_parent());

func mark_destroy():
	pending_destroy = true;
