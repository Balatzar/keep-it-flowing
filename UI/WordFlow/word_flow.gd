extends Control

@export var WordScene: PackedScene

@export_group("Filler Words Timing")
@export var min_spawn_time: float = 0.5
@export var max_spawn_time: float = 2.0
@export var min_display_time: float = 0.5
@export var max_display_time: float = 1.5

var phrases_by_phases = {
	1: "Today at shool there was...",
	2: "And it was really...",
	3: "So I...",
	4: "But then it...",
	5: "So I decided to...",
	6: "I'm telling you because you are not...",
	7: "But I will tell..."
}

var filler_words = ["And", "Uh", "Emm", "You know", "And then", "You see", "There was"]
var filler_spawn_timer: Timer
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $HBoxContainer.get_children():
		child.queue_free()
	GlobalState.state_changed.connect(_on_state_changed)
	_update_current_phrase()
	
	# Initialize the timer but don't start it yet
	filler_spawn_timer = Timer.new()
	add_child(filler_spawn_timer)
	filler_spawn_timer.timeout.connect(_spawn_random_filler_word)

func start_filler_words() -> void:
	filler_spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	filler_spawn_timer.start()

func stop_filler_words() -> void:
	filler_spawn_timer.stop()
	
	# Clear any existing filler words
	for child in $HBoxContainer.get_children():
		child.queue_free()

func _spawn_random_filler_word() -> void:
	# Only spawn if we're in THINKING state
	if GlobalState.current_state != GlobalState.State.THINKING:
		stop_filler_words()
		return
		
	# Get a random filler word
	var random_word = filler_words[randi() % filler_words.size()]
	
	# Create the word instance
	var word_instance = WordScene.instantiate()
	word_instance.word = random_word
	$HBoxContainer.add_child(word_instance)
	
	# Create disappear timer with random duration
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = randf_range(min_display_time, max_display_time)
	timer.one_shot = true
	
	# Store reference to word_instance in the timer
	timer.set_meta("word_instance", word_instance)
	
	timer.timeout.connect(func():
		var stored_word = timer.get_meta("word_instance")
		if is_instance_valid(stored_word):
			stored_word.queue_free()
		timer.queue_free()
	)
	timer.start()
	
	# Set next spawn interval
	filler_spawn_timer.wait_time = randf_range(min_spawn_time, max_spawn_time)
	filler_spawn_timer.start()

func _update_current_phrase() -> void:
	if phrases_by_phases.has(GlobalState.game_phase):
		$CurrentPhrase.text = phrases_by_phases[GlobalState.game_phase]

func _on_state_changed(new_state):
	print(new_state)
	if new_state == GlobalState.State.SELECTING_WORD:
		stop_filler_words()
		# Instanciate a new word and add it to the scene
		var word_instance = WordScene.instantiate()
		word_instance.word = GlobalState.selected_word.get("name")
		$HBoxContainer.add_child(word_instance)
		
		# Create a timer to make the word disappear
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 1.5
		timer.one_shot = true
		timer.timeout.connect(_on_selected_word_display_timeout)
		timer.start()
	elif new_state == GlobalState.State.THINKING:
		_update_current_phrase()
		start_filler_words()
	elif new_state == GlobalState.State.RESPONDING:
		# Get the score from selected word
		var score = GlobalState.selected_word.get("value")
		var rating = GlobalState.get_score_rating(score)
		
		# Create word instance to display rating word
		var word_instance = WordScene.instantiate()
		word_instance.word = GlobalState.get_rating_word(rating)
		$HBoxContainer.add_child(word_instance)
		
		# Create a timer to transition back to THINKING
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.timeout.connect(_on_responding_timer_timeout)
		timer.start()

func _on_selected_word_display_timeout():
	# Clear all words
	for child in $HBoxContainer.get_children():
		child.queue_free()
	
	# Increment game phase
	GlobalState.game_phase += 1
	
	# Change state to RESPONDING
	GlobalState.change_state(GlobalState.State.RESPONDING)

func _on_responding_timer_timeout():
	# Clear all words
	for child in $HBoxContainer.get_children():
		child.queue_free()
		
	# Change state back to THINKING
	GlobalState.change_state(GlobalState.State.THINKING)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
