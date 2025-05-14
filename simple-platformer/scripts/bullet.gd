extends Node2D

const SPEED : int = 300;
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta;
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free();





func _on_area_2d_body_entered(body: Node2D) -> void:
	print("bullet body entered:")
	print(body)
	animation_player.play("hitted")


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("bullet area entered:")
	print(area)
	animation_player.play("hitted")
