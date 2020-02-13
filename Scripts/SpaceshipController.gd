extends KinematicBody2D

export var acceleration = 100;
export var deacceleration_multiplier = 4;
export var turn_rate_acceleration = 360;
export var turn_rate_deaccel_multiplier = 2;

export var max_speed = 10;
export var max_turn_rate = 180;

var velocity;
var turn_rate;

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO;
	turn_rate = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var move_direction = Vector2.RIGHT.rotated(rotation);
	
	var force = Vector2.ZERO;
	
	if(Input.is_action_pressed("ui_up")):
		force = move_direction * acceleration * delta;
	if(Input.is_action_pressed("ui_left")):
		turn_rate -= turn_rate_acceleration * delta;
	if(Input.is_action_pressed("ui_right")):
		turn_rate += turn_rate_acceleration * delta;
	
	turn_rate = clamp(turn_rate, -max_turn_rate, max_turn_rate);
	
	velocity += force * delta;
	velocity = velocity.clamped(max_speed);
	rotation += deg2rad(turn_rate);
		
	move_and_collide(velocity);
