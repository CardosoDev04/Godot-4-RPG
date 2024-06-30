class_name State_Idle extends State

var state_name = "idle"
@onready var walk : State = $"../Walk"

# Player enters state
func enter(): 
	player._update_animation(state_name)
	pass

# Player exits state
func exit():
	pass
		

func process(_delta: float) -> State:
	if player.moving_direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
	
func physics(_delta: float) -> State:
	return null

func handleInput(_event: InputEvent) -> State:
	return null	
