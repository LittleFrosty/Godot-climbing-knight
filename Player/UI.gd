extends CanvasLayer

@onready var player:Node = get_node("/root/World/Player");
@onready var label = $Control/Label

func _process(_delta):
	label.text = "x " + str(player.gems)
