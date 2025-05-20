extends Area2D

@onready var spr_gun: Sprite2D = $WeaponPivot/Sprite2D


func _physics_process(delta: float) -> void:
  var enemyes_in_range = get_overlapping_bodies()

  if enemyes_in_range.size() > 0:
    # var target_enemy = enemyes_in_range[0]
    var target_enemy = enemyes_in_range.front()
    look_at(target_enemy.global_position)
    
    
    var angle_deg = float(int(rad_to_deg(rotation)) % 360);
    print(angle_deg)
    if angle_deg > 90 and angle_deg < 270:
      spr_gun.scale.y = -1
    else:
      spr_gun.scale.y = 1
