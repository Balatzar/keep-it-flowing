extends Node2D

func _ready() -> void:
	# Connect to state changes
	GlobalState.state_changed.connect(_on_state_changed)
	# Initially hide win panel
	$WinPanel.hide()

func _on_state_changed(_new_state):
	if GlobalState.game_phase == 8:
		$WordChooser.hide()
		$WordFlow.hide()
		$WinPanel.show()
		
		var final_text = ""
		for phase in range(1, 8):
			# Add the phrase for this phase
			final_text += GameData.get_phrase_for_phase(phase) + " "
			# Add the selected word for this phase if available
			if phase - 1 < GlobalState.selected_words.size():
				final_text += GlobalState.selected_words[phase - 1].get("name") + " "
		
		print(final_text)
		$WinPanel/WinText.text = final_text.strip_edges()

func _process(_delta: float) -> void:
	pass
