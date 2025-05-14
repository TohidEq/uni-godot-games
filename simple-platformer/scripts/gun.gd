extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var marker: Marker2D = $Marker2D

const BULLET = preload("res://scenes/bullet.tscn")

var selected = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select_gun"):
		selected=true;
	if Input.is_action_just_pressed("select_nothing") or Input.is_action_just_pressed("select_sword"):
		selected=false;

	if selected:
		sprite_2d.set_visible(true);
		look_at(get_global_mouse_position());
		# Fix left side looking sprite
		rotation_degrees = wrap(rotation_degrees,0,360);
		if rotation_degrees > 90 and rotation_degrees < 270:
			if scale.y > 0:
				scale.y *= -1;
		else:
			if scale.y < 0:
				scale.y *= -1;

		if Input.is_action_just_pressed("fire"):
			var bullet_instance = BULLET.instantiate();
			get_tree().root.add_child(bullet_instance);
			bullet_instance.global_position = marker.global_position;
			bullet_instance.rotation = rotation;
	else:
		sprite_2d.set_visible(false);
