extends Node2D
@onready var breaking_block = $".";
@onready var destroy_block_timer = $DestroyBlock;
@onready var rebuild_block_timer = $RebuildBlock;
@onready var animation_player = $AnimationPlayer;
@export var destroy_timer:float = 2.0;
@onready var colision = $StaticBody2D/Colision;

var is_breaking:bool = false;

func _ready():
	destroy_block_timer.wait_time = destroy_timer;

func _on_area_2d_body_entered(body:Node) -> void:
	if body.name == 'Player' and is_breaking == false:
		is_breaking = true;
		destroy_block_timer.start();
		animation_player.play("Breaking");
		

func _on_destroy_block_timeout():
	colision.disabled = true;
	breaking_block.visible = false;
	animation_player.stop();
	rebuild_block_timer.start();

func _on_rebuild_block_timeout():
	colision.disabled = false;
	breaking_block.visible = true;
	is_breaking = false;


