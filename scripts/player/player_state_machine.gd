class_name PlayerStateMachine extends Node

var states : Array[State]
var prev_state : State
var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Call process of the current state and return either a state (to change to) or null (no state change)
func _process(delta):
	_changeState(current_state.process(delta))
	pass

# Calls the current state's physics process
func _physics_process(delta):
	_changeState(current_state.physics(delta))
	pass	

# Handles input on the current state returning either a new state or the same (null)
func _unhandled_input(event):
	_changeState(current_state.handleInput(event))

func initialize(_player: Player):
	states = []
	
	for child in get_children():
		if child is State:
			states.append(child)
	
	if states.size() > 0:
		states[0].player = _player		
		_changeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func _changeState(new_state: State):
	if new_state == current_state || new_state == null:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()	
