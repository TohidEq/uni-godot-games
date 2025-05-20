extends Node2D
@onready var path_follow_2d: PathFollow2D = $Player/Path2D/PathFollow2D





func spawn_mob():
  var new_mob = preload("res://mob/mob.tscn").instantiate()
  path_follow_2d.progress_ratio = randf()
  new_mob.global_position= path_follow_2d.global_position
  add_child(new_mob)


func _on_timer_timeout() -> void:
  spawn_mob()

@onready var game_over: CanvasLayer = $GameOver

func _on_player_health_depleted() -> void:
  game_over.visible =true
  get_tree().paused=true
  
