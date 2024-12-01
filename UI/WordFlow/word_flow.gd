extends Control

@export var WordScene: PackedScene

var phrases_by_phases = {
	1: "Today at shool there was...",
	2: "And it was really...",
	3: "So I...",
	4: "But then it...",
	5: "So I decided to...",
	6: "I'm telling you because you are not...",
	7: "But I will tell..."
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $HBoxContainer.get_children():
		child.queue_free()
	GlobalState.state_changed.connect(_on_state_changed)
	_update_current_phrase()

func _update_current_phrase() -> void:
	if phrases_by_phases.has(GlobalState.game_phase):
		$CurrentPhrase.text = phrases_by_phases[GlobalState.game_phase]

func _on_state_changed(new_state):
	print(new_state)
	if new_state == GlobalState.State.SELECTING_WORD:
		# Instanciate a new word and add it to the scene
		var word_instance = WordScene.instantiate()
		word_instance.word = GlobalState.selected_word.get("name")
		$HBoxContainer.add_child(word_instance)
		
		# Create a timer to make the word disappear
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.timeout.connect(_on_word_timer_timeout)
		timer.start()
	elif new_state == GlobalState.State.THINKING:
		_update_current_phrase()

func _on_word_timer_timeout():
	# Clear all words
	for child in $HBoxContainer.get_children():
		child.queue_free()
	
	# Increment game phase
	GlobalState.game_phase += 1
	
	# Change state back to THINKING
	GlobalState.change_state(GlobalState.State.THINKING)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
