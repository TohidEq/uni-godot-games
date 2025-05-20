extends Area2D

@onready var spr_gun: Sprite2D = $WeaponPivot/Sprite2D

const BULLET = preload("res://bullet/bullet.tscn")

var is_enemy_close = false;

func _process(delta: float) -> void:
  rotation_degrees = wrap(rotation_degrees,0,360);
  if rotation_degrees > 90 and rotation_degrees < 270:
    if scale.y > 0:
      scale.y *= -1;
  else:
    if scale.y < 0:
      scale.y *= -1;


func _physics_process(delta: float) -> void:
  var enemyes_in_range = get_overlapping_bodies()
  if enemyes_in_range.size() > 0:
    # var target_enemy = enemyes_in_range[0]
    var target_enemy = enemyes_in_range.front()
    look_at(target_enemy.global_position)
    is_enemy_close=true
  else:
    is_enemy_close=false
  
  if Input.is_action_pressed("shoot"):
    look_at(get_global_mouse_position())


 


func shoot():
  # var new_bullet = BULLET.instantiate()
  # new_bullet.global_position= %BulletSpawnPoint.global_position

  var bullet_instance = BULLET.instantiate();
  get_tree().root.add_child(bullet_instance);
  bullet_instance.global_position = %BulletSpawnPoint.global_position;
  bullet_instance.rotation = rotation;


func _on_timer_timeout() -> void:
  if is_enemy_close:
    shoot()
  pass # Replace with function body.
