extends Area2D

var traveled_distance = 0;

const SPEED = 1000;
const RANGE = 1200;

# func _physics_process(delta: float) -> void:
#   var direction = Vector2.RIGHT.rotated(rotation);
#   position = direction * SPEED * delta
#   traveled_distance += 1000*delta
#   if traveled_distance >= RANGE:
#     queue_free()


func _process(delta: float) -> void:
  
  position += transform.x * SPEED * delta;

  traveled_distance += SPEED*delta

  if traveled_distance >= RANGE:
    queue_free()


func _on_body_entered(body: Node2D) -> void:
  queue_free()
  if body.has_method("take_damage"):
    print("body:")
    print(body)
    body.take_damage();
  if body.has_method("fallback"):
    body.fallback(0.005)
