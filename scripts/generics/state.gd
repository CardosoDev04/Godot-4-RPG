class_name State extends Node

static var player: Player


func _ready():
	pass # Replace with function body.


# Player enters state
func enter(): 
	pass

# Player exits state
func exit():
	pass
		

func process(_delta: float) -> State:
	return null
	
	
func physics(_delta: float) -> State:
	return null

func handleInput(_event: InputEvent) -> State:
	return null	
