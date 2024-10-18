#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name World extends Node3D

## 场景资源
@onready var world: World = $"."
@onready var main: Node3D = $Main
@onready var interface: Interface = $Interface

## 场景数据
@export var is_player_loader: bool = false

## 场景预加载资源
@onready var player_scene: PackedScene = preload("res://scenes/world/player/player.tscn")

## 准备就绪
func _ready() -> void:
	print("[world]:_ready")
	if Base.is_server():
		on_server_loader_map()
		return
	main.visible = false

## 帧渲染
func _process(_delta: float) -> void:
	if !Base.is_server():
		if !is_player_loader:
			on_player_loader()

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass

## 服务器加载地图资源函数
func on_server_loader_map() -> void:
	print("[world]:on_server_loader_map")
	# TODO 在服务器请求地图资源接口并加载地图资源，完成后加载NPC资源
	on_server_loader_npc()

## 服务器加载NPC资源函数
func on_server_loader_npc() -> void:
	print("[world]:on_server_loader_npc")
	# TODO 在服务器请求NPC资源接口并加载地图的NPC资源，完成后加载怪物资源
	on_server_loader_monster()

## 服务器加载怪物资源函数
func on_server_loader_monster() -> void:
	print("[world]:on_server_loader_monster")

## 加载玩家资源函数
func on_player_loader() -> void:
	print("[world]:on_player_loader")
	var map_path: String = Account.get_player_map_path({})
	ResourceLoader.load_threaded_request(map_path)
	var loader_status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(map_path, interface.loader_progress)
	interface.loading_progress_bar.value = (interface.loader_progress[0] * 100)
	if loader_status == ResourceLoader.THREAD_LOAD_LOADED:
		is_player_loader = true
		var map_scene: Node3D = load(map_path).instantiate()
		var map_players_node: Node3D = map_scene.get_node("Main").get_node("Players")
		var player_node: Player = player_scene.instantiate()
		player_node.name = Account.get_player_token({})
		map_players_node.add_child(player_node)
		main.add_child(map_scene)
		await get_tree().create_timer(1.5).timeout
		interface.loading.visible = false
		interface.main.visible = true
		main.visible = true
