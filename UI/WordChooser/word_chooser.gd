extends Control

@export var WordToChooseScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalState.state_changed.connect(_on_state_changed)
	_show_words_for_phase(GlobalState.game_phase)

func _show_words_for_phase(phase: int) -> void:
	# Clear existing words
	for child in $HBoxContainer.get_children():
		child.queue_free()
		
	var words = GameData.get_words_for_phase(phase)
	for word in words:
		var word_instance = WordToChooseScene.instantiate()
		print(word)
		word_instance.word = word
		$HBoxContainer.add_child(word_instance)
		word_instance.word_selected.connect(_on_word_selected.bind(word_instance))

func _on_state_changed(new_state):
	if new_state == GlobalState.State.THINKING:
		_show_words_for_phase(GlobalState.game_phase)

func _on_word_selected(word: Dictionary, word_instance: Node):
	print("Selected word: %s, Value: %d" % [word["name"], word["value"]])
	# Remove the word from available_words
	GameData.remove_word(GlobalState.game_phase, word)
	GlobalState.select_word(word)
	# Remove the word instance from UI immediately
	word_instance.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
