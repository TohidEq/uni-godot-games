extends Camera2D
@onready var player: CharacterBody2D = $"../Player"

const follow_speed=5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.is_alive:
		global_position = global_position.lerp(player.global_position, follow_speed * delta)
	pass
