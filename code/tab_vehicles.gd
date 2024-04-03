extends TabContainer


@onready var unit_template = load("res://resources/UI_elements/vehicle_template.tscn")


func load_json(path):
	var file = FileAccess.open(path, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())


func load_unit(path):
	var data = load_json(path)
	if data == null:
		OS.alert("Failed to load json")
		return null
	
	var unit_tab = unit_template.instantiate()
	add_child(unit_tab)
	unit_tab._on_line_edit_text_submitted(data["name"])
	var path2scheme = path.substr(0, path.rfind("/")) + "/" + data["scheme"]
	var image = Image.load_from_file(path2scheme)
	var texture = ImageTexture.create_from_image(image)
	var sprite_scheme = unit_tab.get_node("sprite_scheme")
	sprite_scheme.texture = texture


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_vehicle():
	pass
