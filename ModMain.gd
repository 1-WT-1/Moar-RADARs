extends Node

const MOD_PRIORITY = 0
const MOD_NAME = "Moar RADARs!"
const MOD_VERSION_MAJOR = 2
const MOD_VERSION_MINOR = 0
const MOD_VERSION_BUGFIX = 4
const MOD_VERSION_METADATA = ""

var modPath: String = get_script().resource_path.get_base_dir() + "/"
var _savedObjects := []

func _init(modLoader = ModLoader):
	l("Initializing")
	
	installScriptExtension("hud/LIDAR.gd")
	replaceScene("hud/components/LIDAR.tscn")
	replaceScene("enceladus/Upgrades.tscn")
	replaceScene("enceladus/Tuning.tscn")

	l("Initialized")

func l(msg: String, title: String = MOD_NAME, version: String = str(MOD_VERSION_MAJOR) + "." + str(MOD_VERSION_MINOR) + "." + str(MOD_VERSION_BUGFIX)):
	if not MOD_VERSION_METADATA == "":
		version = version + "-" + MOD_VERSION_METADATA
	Debug.l("[%s V%s]: %s" % [title, version, msg])

func installScriptExtension(path: String):
	var childPath: String = str(modPath + path)
	var childScript: Script = ResourceLoader.load(childPath)
	childScript.new()
	var parentScript: Script = childScript.get_base_script()
	var parentPath: String = parentScript.resource_path
	childScript.take_over_path(parentPath)

func replaceScene(newPath: String, oldPath: String = ""):
	if oldPath.empty():
		oldPath = str("res://" + newPath)
	newPath = str(modPath + newPath)
	var scene := load(newPath)
	scene.take_over_path(oldPath)
	_savedObjects.append(scene)
