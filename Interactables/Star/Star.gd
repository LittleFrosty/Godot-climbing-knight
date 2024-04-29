extends Node2D

@onready var point_light_2d = $PointLight2D

func _on_area_2d_body_entered(body):
	body.gems += 1;
	queue_free();
