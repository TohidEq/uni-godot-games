extends CharacterBody2D

signal health_depleted;

@onready var happy_boo: Node2D = $HappyBoo
@onready var progress_bar: ProgressBar = $ProgressBar

const SPEED = 300.0
const DAMAGE_RATE = 5.0

var health = 100.0

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

  var overlapping_mobs = %HitBox.get_overlapping_bodies()

  if overlapping_mobs.size() > 0:
    health -= DAMAGE_RATE*overlapping_mobs.size()*delta
    progress_bar.value=health
    if health <= 0.0:
      health_depleted.emit()
