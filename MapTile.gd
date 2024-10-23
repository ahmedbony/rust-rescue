# MapTile.gd
extends TextureRect

@export var api_key: String = "AIzaSyCWkRyynUhoA9BGFVcTf_D96QJ7WsQ0Lks"  # Replace with your actual API key
@export var center_latitude: float = 32.27994043230601  # Default to San Francisco
@export var center_longitude: float = -106.75172853695162 
@export var zoom: int = 15  # Zoom level

@export var map_width: int = 1280  # Set the width of the map
@export var map_height: int = 1280  # Set the height of the map

var menu_instance


func _ready() -> void:

	show_menu()
	download_map_tile()
	
func show_menu():
	# Load and instance the menu scene
	var menu_scene = load("res://menu.tscn")  # Replace with the actual path to your Menu scene
	menu_instance = menu_scene.instantiate()  # Instantiate the scene
	add_child(menu_instance)  # Add the menu to the scene

# Optional: Handle toggling the menu with a key (e.g., "Escape" key)
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):  # Assuming "Esc" is mapped to ui_cancel
		if menu_instance == null:
			show_menu()  # Show the menu if it's not already on
		else:
			menu_instance.queue_free()  # Remove the menu
			menu_instance = null

func download_map_tile() -> void:
	#var url = "https://maps.googleapis.com/maps/api/staticmap?center=%s,%s&zoom=%d&size=640x640&key=%s" % [
		#center_latitude, center_longitude, zoom, api_key
	#]
	#var url = "https://maps.googleapis.com/maps/api/staticmap?center=%s,%s&zoom=%d&size=%dx%d&key=%s" % [
		#center_latitude, center_longitude, zoom, map_width, map_height, api_key
	#]
	
	var url = "https://maps.googleapis.com/maps/api/staticmap?center=%s,%s&zoom=%d&size=640x640&scale=1&key=%s" % [
		center_latitude, center_longitude, zoom, api_key
	]
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	http_request.request(url)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var image = Image.new()
		image.load_png_from_buffer(body)
		texture = ImageTexture.create_from_image(image)
	else:
		print("Failed to load map: ", response_code)
