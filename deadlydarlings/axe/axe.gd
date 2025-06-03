extends Node2D

@onready var fire_rate_animation: AnimationPlayer = $FireRateAnimation


@export var normal_firerate = 0.7
var fire_rate = normal_firerate;

var selected = true;

@onready var timer: Timer = $Timer

func _ready() -> void:
  set_visible(false)


func select_wpn(value=true):
  selected = value;



func _process(delta: float) -> void:
  #set_visible(selected)
  timer.set_wait_time(1.8 - fire_rate + 0.05)



@onready var axe_pivot: Marker2D = $AxePivot


func start_boost_firerate():
  axe_pivot.scale.x=1.5
  fire_animation.speed_scale=2
  fire_rate = 1.8;
  shoot()
  
  
func end_boost_firerate():
  axe_pivot.scale.x=1
  fire_animation.speed_scale = 1
  fire_rate = normal_firerate



# mishe ye item ro zamin gozasht ke age khordimesh, in func ejra she...(10 sanie boost)s
func boost_firerate():
  fire_rate_animation.play("boost_firerate")
  

@onready var fire_animation: AnimationPlayer = $FireAnimation

func shoot():
  if selected:
    set_visible(true)
    fire_animation.play("spin")
  
  


func _on_timer_timeout() -> void:
  if selected:
    shoot()
    
    



func _on_area_2d_body_entered(body: Node2D) -> void:
  if body.has_method("take_damage"):
    #print("body:")
    #print(body)
    body.take_damage();
  if body.has_method("fallback"):
    body.fallback(0.1)
