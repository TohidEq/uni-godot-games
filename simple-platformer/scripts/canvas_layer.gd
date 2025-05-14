extends CanvasLayer
@onready var cam: Camera2D = $"../Camera2D"
@onready var lbl: Label = $ScoreOnly

@export var limit_bottom := 230

func _process(delta):
	if not cam or not lbl:
		return
	
	var cam_pos = cam.global_position
	var y_clamped = min(cam_pos.y, limit_bottom)
	lbl.position = Vector2(20, y_clamped - cam_pos.y + 20)
