class_name State_Walk extends State

var state_name = "walk"

@export var move_speed : float = 100.0
@onready var idle: State = $"../Idle"

# Player enters state
func enter(): 
	player._update_animation(state_name)
	player._set_active_sprite(state_name)
	pass

# Player exits state
func exit():
	pass
		

func process(_delta: float) -> State:
	if player.moving_direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.moving_direction * move_speed
	
	if player._set_direction():
		player._update_animation(state_name)
		
	return null
	
	
func physics(_delta: float) -> State:
	return null

func handleInput(_event: InputEvent) -> State:
	return null	
