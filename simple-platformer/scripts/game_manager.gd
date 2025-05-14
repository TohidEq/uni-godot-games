extends Node
@onready var score_label: Label = $"../Labels/ScoreLabel"
@onready var score_only: Label = $"../CanvasLayer/ScoreOnly"

var score = 0;

func add_point():
	score+=1;
	print(score);
	score_label.text="You Collected "+ str(score) + " Coins!"
	score_only.text="Score: "+str(score)
		
