# Menu.gd
extends Control

# This function will be called when the Start button is pressed
func _on_StartButton_pressed():
	# Removes the menu and resumes the game
	queue_free()  # Remove the menu scene
	
# This function will be called when the Quit button is pressed
func _on_QuitButton_pressed():
	# Quit the game
	get_tree().quit()

# Connect the button signals in _ready or in the scene editor's signals
func _ready():
	# Connect button signals (if not done through the editor)
	$VBoxContainer/StartButton.pressed.connect(_on_StartButton_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_QuitButton_pressed)
