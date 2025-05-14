extends Node2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slime_healthbar: AnimatedSprite2D = $Node2D/slimeHealthbar

const SPEED = 60;
var direction = 1;

@export var slime_max_health = 5;
var slime_health = slime_max_health;
@export var slime_max_healthbar_size:float = 1.40;
var slime_healthbar_size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	

	if ray_cast_left.is_colliding():
		var collider = ray_cast_left.get_collider()
		direction = 1
		

	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		direction = -1
	
	
	
	animated_sprite_2d.flip_h = direction == 0
	
	position.x += direction*SPEED*delta;


func reduce_health():
	slime_health -=1 ;
	slime_healthbar_size = (slime_health * slime_max_healthbar_size) / slime_max_health;
	slime_healthbar.scale.x = slime_healthbar_size;
	
	
	
	if slime_health<=0:
		queue_free();
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("--------------------------\n========================\n-------------------------")
	print("hitbox")
	print(area)
	reduce_health()
	print("enemy health:")
	print(slime_health)
	
	
	
