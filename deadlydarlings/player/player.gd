extends CharacterBody2D

signal health_depleted;

@onready var happy_boo: Node2D = $HappyBoo
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer
@onready var mana_bar: ProgressBar = $ManaBar
@onready var gun: Area2D = $Gun


const SPEED = 300.0
const DAMAGE_RATE = 5.0
var health = 100.0

var mana = 100;
var mana_drain_rate = 2;
var mana_refill_rate = 1;

func _ready() -> void:
  #timer.set_wait_time(0.1)
  pass

func _physics_process(delta: float) -> void:
  mana_bar.value=mana
  
  if (mana<100 and not Input.is_action_just_pressed("boost")):
    mana += mana_refill_rate
  
  if Input.is_action_pressed("boost"):
    if(mana>0):
      mana -= mana_drain_rate
      
      gun.start_boost_firerate();
    else:
      gun.end_boost_firerate();
  if Input.is_action_just_released("boost"):
    gun.end_boost_firerate();
  
  
  
  
  var direction = Input.get_vector("move_left","move_right","move_up","move_down");
  velocity = direction * SPEED
  move_and_slide()

  #print("move direction")
  #print(direction[0])

  if direction[0] != 0:
    happy_boo.get_node("Colorizer").scale.x = 1 if direction[0]>0 else -1;




  if velocity.length() > 0.0:
    happy_boo.play_walk_animation()
  else:
    happy_boo.play_idle_animation()

  var overlapping_mobs = %HitBox.get_overlapping_bodies()
  

  if overlapping_mobs.size() > 0:
    health -= DAMAGE_RATE * overlapping_mobs.size() * delta
    progress_bar.value=health
    if health <= 0.0:
      health_depleted.emit()


func _on_hit_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
  body.play_hitting()

func _on_hit_box_body_entered(body: Node2D) -> void:
  body.play_hitting()
