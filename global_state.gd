extends Node

# Define states
enum State { START, THINKING, SELECTING_WORD }

# Current state
var current_state: State = State.START

var selected_word: Dictionary = {}
var game_phase: int = 1

# Signal to broadcast state changes
signal state_changed(new_state: State)

func select_word(word: Dictionary):
	selected_word = word
	change_state(State.SELECTING_WORD)

# Function to change the state
func change_state(new_state: State):
	if current_state != new_state:
		current_state = new_state
		emit_signal("state_changed", new_state)
		print("State changed to:", new_state)
