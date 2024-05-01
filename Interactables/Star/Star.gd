extends Node2D
@onready var collect = $collect
@onready var point_light_2d = $PointLight2D

func _on_area_2d_body_entered(body):
	collect.play();
	body.gems += 1;
	visible = false;
	
func _on_collect_finished():
	queue_free();
