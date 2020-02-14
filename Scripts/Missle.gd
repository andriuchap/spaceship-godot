extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * 1000.0 * delta;

func _on_DeathTimer_timeout():
	get_parent().remove_child(self);

func _on_Missle_body_entered(body):
	get_parent().remove_child(self);
	body._break();
