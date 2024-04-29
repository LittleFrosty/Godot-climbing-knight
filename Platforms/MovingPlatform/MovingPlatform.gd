extends AnimatableBody2D
@onready var animation_player = $AnimationPlayer
@onready var platform = $"."
@export var start = Vector2();
@export var finish = Vector2();
@export var duration = 1;
# Called when the node enters the scene tree for the first time.
func _ready():
	platform.position = start;
	animation_player.play("move");
