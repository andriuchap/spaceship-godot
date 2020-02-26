extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * 1000.0 * delta;

func _on_DeathTimer_timeout():
	destroy_missile()

func _on_Missle_body_entered(body):
	destroy_missile()
	body._break();

func destroy_missile():
	$SelfDestroy.mark_destroy();
