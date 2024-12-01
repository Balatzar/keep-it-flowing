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
	],
	3: [
		{"name": "Run away", "value": 152},
		{"name": "Stay calm", "value": 171},
		{"name": "Ask for help", "value": 91},
		{"name": "Fix it", "value": 10},
		{"name": "Ignore it", "value": 0},
		{"name": "Write about it", "value": 264},
		{"name": "Laugh it off", "value": 15},
		{"name": "Cry", "value": 100},
		{"name": "Tell a friend", "value": 5},
		{"name": "Keep it secret", "value": 295}
	],
	4: [
		{"name": "Scary", "value": 18},
		{"name": "Mean", "value": 22},
		{"name": "Silly", "value": 0},
		{"name": "Helpful", "value": 154},
		{"name": "Strict", "value": 207},
		{"name": "Distracted", "value": 267},
		{"name": "Confused", "value": 71},
		{"name": "Busy", "value": 241},
		{"name": "Angry", "value": 102},
		{"name": "Patient", "value": 10}
	],
	5: [
		{"name": "Alice", "value": 220},
		{"name": "Benjamin", "value": 0},
		{"name": "Clara", "value": 0},
		{"name": "David", "value": 263},
		{"name": "Elodie", "value": 107},
		{"name": "Felix", "value": 0},
		{"name": "Gabrielle", "value": 250},
		{"name": "Hugo", "value": 197},
		{"name": "Isabelle", "value": 222},
		{"name": "Jules", "value": 162}
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
