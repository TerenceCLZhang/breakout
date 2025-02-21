extends Resource

class_name SaveData

@export var best_score := 0
const SAVE_PATH = "user://save_data.tres"


func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)


static func load_or_create() -> SaveData:
	var resource: SaveData
	if FileAccess.file_exists(SAVE_PATH): resource = load(SAVE_PATH) as SaveData
	else: resource = SaveData.new()
	return resource
