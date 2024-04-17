extends Control


enum FileDialogState {
	NONE,
	OPEN_SESSION,
	SAVE_SESSION,
	OPEN_UNIT,
	SAVE_UNIT,
}


var file_dialog_state = FileDialogState.NONE


@onready var file_dialog = $file_dialog
@onready var tab_vehicles = $tab_vehicles


func load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())
	

func load_session(path):
	var data = load_json(path)
	if data == null:
		OS.alert("Failed to load json")
		return null
	for vehicle_path in data["vehicles"]:
		var veh_path = path.substr(0, path.rfind("/"))+"/"+vehicle_path
		tab_vehicles.load_unit(veh_path)

func save_session(path):
	var selected_tab = tab_vehicles.current_tab
	for i in range(tab_vehicles.get_tab_count()):
		tab_vehicles.current_tab = i
	
	tab_vehicles.current_tab = selected_tab


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_new_session_pressed():
	pass # Replace with function body.


func _on_button_open_session_pressed():
	file_dialog_state = FileDialogState.OPEN_SESSION
	file_dialog.file_mode = file_dialog.FILE_MODE_OPEN_FILE
	file_dialog.title = "Load a Session File"
	file_dialog.show()


func _on_button_save_session_pressed():
	file_dialog_state = FileDialogState.SAVE_SESSION
	file_dialog.file_mode = file_dialog.FILE_MODE_SAVE_FILE
	file_dialog.title = "Save a Session File"
	file_dialog.show()


func _on_button_open_unit_pressed():
	file_dialog_state = FileDialogState.OPEN_UNIT
	file_dialog.file_mode = file_dialog.FILE_MODE_OPEN_FILE
	file_dialog.title = "Load Unit File"
	file_dialog.show()


func _on_button_save_unit_pressed():
	file_dialog_state = FileDialogState.SAVE_UNIT
	file_dialog.file_mode = file_dialog.FILE_MODE_SAVE_FILE
	file_dialog.title = "Save Unit File"
	file_dialog.show()


func _on_file_dialog_file_selected(path):
	print(path)
	match file_dialog_state:
		FileDialogState.OPEN_SESSION:
			load_session(path)
		FileDialogState.OPEN_UNIT:
			tab_vehicles.load_unit(path)
		FileDialogState.SAVE_SESSION:
			save_session(path)
		FileDialogState.SAVE_UNIT:
			tab_vehicles.save_unit(path)
