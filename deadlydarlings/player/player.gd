extends CharacterBody2D

@onready var happy_boo: Node2D = $HappyBoo

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down");
	velocity = direction*600
	move_and_slide()

	print("move direction")
	print(direction[0])

	if direction[0] != 0:
		happy_boo.get_node("Colorizer").scale.x = 1 if direction[0]>0 else -1;




	if velocity.length() > 0.0:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()
