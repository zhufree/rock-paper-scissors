# SceneManager.gd
extends Node

var instance: SceneManager = null
var current_scene = preload("res://Index.tscn").instantiate()
var scene_container = null
signal scene_change_requested(new_scene_path)

func _init():
	instance = self

# 请求切换到一个新的场景
func change_scene(new_scene_path: String):
	emit_signal("scene_change_requested", new_scene_path)

# 实际执行场景切换的操作
func perform_scene_change(new_scene_path: String):
	current_scene.queue_free()
	var new_scene = load(new_scene_path).instantiate()
	scene_container.add_child(new_scene)
	current_scene = new_scene

func _ready():
	set_process(false)
	scene_container = get_tree().get_current_scene()
	scene_container.add_child(current_scene)
