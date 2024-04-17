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
	unit_tab.datadict = data
	
	var scrollbar_systems = unit_tab.get_node("sprite_scheme")
	var label_pos = sprite_scheme.position
	label_pos.x += texture.get_width()
	print(label_pos)
	for sys_name in data["systems"]:
		var label = Label.new()
		label.text = data["systems"][sys_name]["name"]
		label.tooltip_text = data["systems"][sys_name]["desctiption"]
		label.mouse_filter = Control.MOUSE_FILTER_PASS
		scrollbar_systems.add_child(label)
		label.position = label_pos
		label.size = unit_tab.edit_name.size
		label_pos.y += label.size.y


func save_unit(path):
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
