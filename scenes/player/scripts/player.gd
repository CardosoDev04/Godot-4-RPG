class_name Player extends CharacterBody2D

var move_speed : float = 100.0
var facing_direction: Vector2 = Vector2.DOWN
var moving_direction: Vector2 = Vector2.ZERO
var state : String = "idle"

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var idle_sprite : Sprite2D = $Idle
@onready var walk_sprite : Sprite2D = $Walk

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_active_sprite(state)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	moving_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	moving_direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if _set_state() || _set_direction():
		_set_active_sprite(state)
		_update_animation()
		
	
	velocity = moving_direction * move_speed
	
	_update_animation()


func _physics_process(delta):
	move_and_slide()
	

func _set_direction() -> bool:
	var new_direction : Vector2 = facing_direction
	
	if moving_direction == Vector2.ZERO:
		return false
	
	if moving_direction.y == 0:
		new_direction = Vector2.LEFT if moving_direction.x < 0 else Vector2.RIGHT	
	elif moving_direction.x == 0:
		new_direction = Vector2.UP if moving_direction.y < 0 else Vector2.DOWN
			
	if new_direction == facing_direction:
		return false
	
	facing_direction = new_direction
	_update_sprite_flip()	
	return true
	
func _set_state() -> bool:
	var new_state : String = "idle" if moving_direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
			
	state = new_state		
	return true
	

func _update_animation():
	animation_player.play(state + "_" + _anim_direction())
	pass	

func _set_active_sprite(state: String):
	if state == "walk":
		idle_sprite.hide()
		walk_sprite.show()
	else:
		idle_sprite.show()
		walk_sprite.hide()	
		
func _anim_direction() -> String:
	if facing_direction == Vector2.DOWN:
		return "down"
	elif facing_direction == Vector2.UP:
		return "up"	
	else:
		return "side"		
		
func _update_sprite_flip():
	idle_sprite.scale.x = 1 if facing_direction == Vector2.LEFT else -1
	walk_sprite.scale.x = -1 if facing_direction == Vector2.LEFT else 1		
