extends CharacterBody2D



#@onready var player = get_node("Game/player");
@onready var player: CharacterBody2D = $"../Player"
@onready var slime: Node2D = $Slime
@onready var progress_bar: ProgressBar = $ProgressBar

@export var speed = 200.0;

var health = 3;

func _ready() -> void:
  slime.play_walk()

func _physics_process(delta: float) -> void:
  var direction = global_position.direction_to(player.global_position);


  velocity = direction * speed;
  move_and_slide()


func take_damage():
  slime.play_hurt()
  health -= 1;
  progress_bar.value=health
  if(health<=0):
    queue_free()
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
  animation_player.play("stop_for_a_moment")
  
