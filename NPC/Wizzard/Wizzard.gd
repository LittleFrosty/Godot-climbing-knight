extends Node2D
@onready var label = $Label
var isPlayerInRange:bool = false;
@onready var animation_player = $Wizzard/AnimationPlayer

@export var currentDialog:int = 0; 
@export var animation:String = 'idle';

var dialog:Array = [
	"Please help me get to the top.
	I'm looking for my wife.",
	"Last time I saw her was
	2 years ago.",
	"Maybe she is at the top?",
	"",
	"We're so close almost at the top"
];

func _ready():
	animation_player.play(animation);

func _input(_event) -> void:
	if isPlayerInRange:
		if(Input.is_action_just_pressed("interact")):
			label.text = dialog[currentDialog];

func _on_area_2d_body_entered(body):
	if body.name == 'Player':
		isPlayerInRange = true;
		label.text = "(E)";


func _on_area_2d_body_exited(body):
	if body.name == 'Player':
		isPlayerInRange = false
		label.text = ""
