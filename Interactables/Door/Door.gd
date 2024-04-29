@tool
extends Node2D

@onready var opened = $Opened
@onready var closed = $Closed
@onready var colider = $Colider
@onready var label = $Label
@export var gems_required:int;


func _ready():
	opened.visible = false;
	closed.visible = true;
	
func openDoor():
	colider.collision_layer = 2;
	opened.visible = true;
	closed.visible = false;

func closeDoor():
	colider.collision_layer = 1;
	opened.visible = false;
	closed.visible = true;


func _on_area_2d_body_entered(body:Node) -> void:
	if body.name == 'Player':
		if body.gems >= gems_required:
			openDoor();
		else:
			label.text = str(gems_required) + " Gems";


func _on_area_2d_body_exited(body:Node) -> void:
	if body.name == 'Player':
		if opened.visible == true:
			
			closeDoor();
		label.text = "";
