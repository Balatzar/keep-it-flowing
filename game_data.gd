extends Node

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
		{"name": "Broke", "value": 204},
		{"name": "Vanished", "value": 300},
		{"name": "Exploded", "value": 15},
		{"name": "Moved", "value": 110},
		{"name": "Stopped", "value": 198},
		{"name": "Fell", "value": 76},
		{"name": "Sang", "value": 9},
		{"name": "Appeared", "value": 120},
		{"name": "Cracked", "value": 164},
		{"name": "Froze", "value": 0}
	],
	5: [
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
	6: [
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
	7: [
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

func get_words_for_phase(phase: int) -> Array:
	if !available_words.has(phase):
		return []
	return available_words[phase]

func remove_word(phase: int, word: Dictionary) -> void:
	if available_words.has(phase):
		available_words[phase].erase(word)

func get_phrase_for_phase(phase: int) -> String:
	return phrases_by_phases.get(phase, "")

func get_random_filler_word() -> String:
	if filler_words.size() == 0:
		return ""
	return filler_words[randi() % filler_words.size()]
