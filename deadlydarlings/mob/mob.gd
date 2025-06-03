extends CharacterBody2D



#@onready var player = get_node("Game/player");
@onready var player: CharacterBody2D = $"../Player"
@onready var slime: Node2D = $Slime
@onready var progress_bar: ProgressBar = $ProgressBar

@export var speed = 200.0;

var point=10;

var health = 3;

var FollowPlayer = 1;

func _ready() -> void:
  slime.play_walk()
  
  if(player.score >100 ):
    scale.x = 1.0 + float(player.score)/1000.0
    scale.y = 1.0 + float(player.score)/1000.0
  
  if scale.x > 5.0:
    scale.x = 5.0
    scale.y = 5.0
    
  point = int(scale.x*10.0)
  

func _physics_process(delta: float) -> void:
  var direction = global_position.direction_to(player.global_position);


  velocity = direction * speed * FollowPlayer;
  move_and_slide()



func take_damage():
  slime.play_hurt()
  health -= 1;
  progress_bar.value=health
  if(health<=0):
    queue_free()
    player.score += point;
    const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
    var smoke = SMOKE_SCENE.instantiate()
    get_parent().add_child(smoke)
    smoke.global_position=global_position
    
    
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func speed_zero():
  speed = 0.0;
func speed_normal():
  speed = 200.0
  
func play_hitting():
  #animation_player.play("stop_for_a_moment")
  pass
  


func start_fallback():
  FollowPlayer = -1;

func end_fallback():
  FollowPlayer = 1
  
  
@onready var fallback_anim: AnimationPlayer = $FallbackAnim

func fallback(fallback_distance = 1.0):
  
  fallback_anim.speed_scale= 1.0-fallback_distance
  fallback_anim.play("fallback")
