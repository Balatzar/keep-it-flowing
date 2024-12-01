extends Control

signal word_selected(word: Dictionary)
var word: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = word.get("name", "Unknown")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("button on pressed")
	word_selected.emit(word)
