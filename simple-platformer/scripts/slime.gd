extends Node2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60;
var direction = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if ray_cast_left.is_colliding():
		var collider = ray_cast_left.get_collider()
		if collider is TileMap:
			direction = 1

	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		if collider is TileMap:
			direction = -1

		
	animated_sprite_2d.flip_h = direction == 0
	
	position.x += direction*SPEED*delta;
