extends Control

@export var WordToChooseScene: PackedScene

var available_words = {
	1: [
		{"name": "An umbrella", "value": 168},
		{"name": "A jellybean", "value": 72},
		{"name": "A lighthouse", "value": 115},
		{"name": "A zipper", "value": 42},
		{"name": "A squirrel", "value": 253},
		{"name": "A pancake", "value": 108},
		{"name": "A spaceship", "value": 133},
		{"name": "A cactus", "value": 0},
		{"name": "A shadow", "value": 120},
		{"name": "A marble", "value": 32}
	],
	2: [
		{"name": "Mysterious", "value": 162},
		{"name": "Nervous", "value": 188},
		{"name": "Frightening", "value": 192},
		{"name": "Excited", "value": 81},
		{"name": "Calm", "value": 29},
		{"name": "Messy", "value": 187},
		{"name": "Intriguing", "value": 289},
		{"name": "Hurt", "value": 253},
		{"name": "Magical", "value": 42},
		{"name": "Exhausted", "value": 0}
	]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalState.state_changed.connect(_on_state_changed)
	_show_words_for_phase(GlobalState.game_phase)

func _show_words_for_phase(phase: int) -> void:
	# Clear existing words
	for child in $HBoxContainer.get_children():
		child.queue_free()
		
	if !available_words.has(phase):
		return
		
	for word in available_words[phase]:
		var word_instance = WordToChooseScene.instantiate()
		print(word)
		word_instance.word = word
		$HBoxContainer.add_child(word_instance)
		word_instance.word_selected.connect(_on_word_selected)

func _on_state_changed(new_state):
	if new_state == GlobalState.State.THINKING:
		_show_words_for_phase(GlobalState.game_phase)

func _on_word_selected(word: Dictionary):
	print("Selected word: %s, Value: %d" % [word["name"], word["value"]])
	GlobalState.select_word(word)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
