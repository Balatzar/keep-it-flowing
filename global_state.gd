extends Node

# Define states
enum State { START, THINKING, SELECTING_WORD, RESPONDING }

# Define score ratings
enum ScoreRating { CRITICAL_FAILURE, FAIL, GOOD, GREAT }

# Map ratings to response words
const RATING_WORDS = {
	ScoreRating.CRITICAL_FAILURE: "Noooooo!",
	ScoreRating.FAIL: "No!",
	ScoreRating.GOOD: "Yes!",
	ScoreRating.GREAT: "Yesssssss!"
}

# Current state
var current_state: State = State.THINKING

var selected_word: Dictionary = {}
var game_phase: int = 1

# Collection of selected words
var selected_words: Array[Dictionary] = []

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

# Function to get score rating from numeric score
func get_score_rating(score: int) -> ScoreRating:
	if score == 0:
		return ScoreRating.CRITICAL_FAILURE
	elif score >= 1 and score <= 99:
		return ScoreRating.FAIL
	elif score >= 100 and score <= 199:
		return ScoreRating.GOOD
	else:  # score >= 200 and score <= 300
		return ScoreRating.GREAT

# Function to get word response for a rating
func get_rating_word(rating: ScoreRating) -> String:
	return RATING_WORDS[rating]

# Function to add a selected word to the collection
func add_selected_word(word: Dictionary):
	selected_words.append(word)
	print("Added selected word: ", word.get("name"), " Value: ", word.get("value"))
