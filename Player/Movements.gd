extends CharacterBody2D
class_name Player;

const JUMP_VELOCITY:int = -310;
const CROUCH_JUMP_VELOCITY = -400;
const max_jump_charge = 1;

var speed:int = 0
var speed_increment = 10;
var maxSpeed = 200;
var can_move = true;

var jump_charged = 0;
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var jump_progress = $Sprite2D/jumpProgress
@export var gems = 0;
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _physics_process(delta) -> void:
	var direction = Input.get_axis("left", "right")
	jump();
	animations();
	movements(delta,direction);
	move_and_slide()
	charge_jump();

func _input(_event):
	jump();
	toggle_crouch_jump();

func movements(delta:float,direction:int):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	elif direction and can_move:
		change_speed(direction)
		velocity.x = speed;
	else:
		velocity.x = speed
		change_speed(0);

func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right")):
		speed = 0;

func toggle_crouch_jump() -> void:
	if Input.is_action_pressed("charge_jump") and is_on_floor():
		can_move = false;
		speed = 0;
	elif Input.is_action_just_released("charge_jump") and is_on_floor():
		velocity.y = CROUCH_JUMP_VELOCITY * jump_charged
		jump_progress.visible = false;
		var currentMaxSpeed:int = (maxSpeed * jump_charged) * 1.2
		if sprite_2d.flip_h == false:
			speed = currentMaxSpeed;
		else:
			speed = -currentMaxSpeed;
		can_move = true;
		jump_charged = 0;
		
func charge_jump() -> void:
	if Input.is_action_pressed("charge_jump") and is_on_floor():
		jump_progress.visible = true;
		if jump_charged < 1:
			jump_charged += 0.03;
			jump_progress.value = jump_charged;
	
func animations() -> void:
	if (Input.is_action_pressed("charge_jump") and is_on_floor()):
		animation_player.play("crouch");
	elif (velocity.y < 0):
		animation_player.play("jump");
	elif (velocity.y > 0):
		animation_player.play("fall");
	elif speed != 0:
		animation_player.play("run");
	else:
		animation_player.play("idle");

func change_speed(type:int) -> void:
	if type == 1:
		# incrase speed going right
		sprite_2d.flip_h = false;
		sprite_2d.position.x = 4;
		if (speed < maxSpeed):
			speed += speed_increment;
	elif type == -1:
		# incrase speed going left
		sprite_2d.flip_h = true;
		sprite_2d.position.x = -4;
		
		if (speed > -maxSpeed):
			speed -= speed_increment;
	elif type == 0:
		# If speed is positive, decrease speed until it reaches 0
		if speed > 0:
			speed -= speed_increment + 10
			if speed < 0:
				speed = 0
		# If speed is negative, increase speed until it reaches 0
		elif speed < 0:
			speed += speed_increment + 10
			if speed > 0:
				speed = 0
