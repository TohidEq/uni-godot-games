extends CharacterBody2D

signal health_depleted;
@onready var score_label: Label = $score

@onready var happy_boo: Node2D = $HappyBoo
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var gun: Area2D = $Gun
@onready var axe: Node2D = $Axe

var score = 0;

enum WPNS{
  GUN,
  AXE
}

const SPEED = 250.0
var change_speed = 0;
var change_speed_per_100xp = 10;
const DAMAGE_RATE = 5.0
var health = 100.0

var mana = 200;
var mana_drain_rate = 2;
var mana_refill_rate = 1;

var wpn = WPNS.GUN
func _ready() -> void:
  #  test
  #position.x=-6430;
  #timer.set_wait_time(0.1)
  choice_wpn()
  pass
  
  
var boosting = false;

func _process(delta: float) -> void:
  score_label.text=str(score)
  #print(position.x)
  if position.x < -4500:
    position.x = -4500;
    
  if position.y < -4500:
    position.y = -4500;
    
  if position.x > 6500:
    position.x = 6500;
    
  if position.y > 3000:
    position.y = 3000;



func _physics_process(delta: float) -> void:
  mana_bar.value=mana
  
  
  if (mana<200 and boosting==false):
    mana += mana_refill_rate
    gun.end_boost_firerate();
    axe.end_boost_firerate();
  
  if (boosting):
    if(mana >10):
      axe.start_boost_firerate();
      gun.start_boost_firerate();
    else:
      gun.end_boost_firerate();
      axe.end_boost_firerate();
  
  
  if Input.is_action_pressed("boost"):
    if mana>=mana_drain_rate:
      mana -= mana_drain_rate
      boosting=true
      
  if Input.is_action_just_released("boost"):
    boosting=false
  
  
  
  
  var direction = Input.get_vector("move_left","move_right","move_up","move_down");
  var increase_speed = change_speed_per_100xp*int(score/100)
  velocity = direction * (SPEED + change_speed + increase_speed)
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


func _input(event: InputEvent) -> void:

  if event.is_action_pressed("select_wpn"):
    happy_boo.get_node("Colorizer").modulate=Color("#ff922d")
    happy_boo.get_node("Colorizer").get_node("SquareBody").get_node("SquareFace").set_visible(true)
    happy_boo.get_node("Colorizer").get_node("SquareBody").get_node("SlimeHurtEyes").set_visible(false)
    
    wpn = WPNS.GUN
  if event.is_action_pressed("select_axe"):
    happy_boo.get_node("Colorizer").modulate=Color("#84181d")
    happy_boo.get_node("Colorizer").get_node("SquareBody").get_node("SquareFace").set_visible(false)
    happy_boo.get_node("Colorizer").get_node("SquareBody").get_node("SlimeHurtEyes").set_visible(true)
    
    wpn = WPNS.AXE
  
  choice_wpn()
    
func choice_wpn() -> void:
  #  unselect all
  gun.select_wpn(false)
  axe.select_wpn(false)
  change_speed = 0;
  #  select the selected one
  match  wpn:
    WPNS.GUN:
      gun.select_wpn(true)
      change_speed=80;
    WPNS.AXE:
      axe.select_wpn(true)
      change_speed=10;
    _:
      print("wrong wpn selected")

func _on_hit_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
  body.play_hitting()

func _on_hit_box_body_entered(body: Node2D) -> void:
  body.play_hitting()
