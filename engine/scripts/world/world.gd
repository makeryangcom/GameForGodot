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
@onready var player_scene: PackedScene = preload("res://scenes/world/players/player.tscn")

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
	var map_path: String = Account.get_player_map_path({})
	ResourceLoader.load_threaded_request(map_path)
	var loader_status: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(map_path, interface.loader_progress)
	interface.loading_progress_bar.value = (interface.loader_progress[0] * 100)
	print("[world]:on_player_loader", " ", interface.loading_progress_bar.value, "%")
	if loader_status == ResourceLoader.THREAD_LOAD_LOADED:
		is_player_loader = true
		# 地图节点处理
		var map_scene: Node3D = load(map_path).instantiate()
		var map_players_node: Node3D = map_scene.get_node("Main").get_node("Players")
		# 玩家节点处理
		var player_node: Player = player_scene.instantiate()
		player_node.name = Account.get_player_token({})
		# 玩家身体模型节点处理
		var body_model_path: String = Account.get_player_body_model_path({})
		var body_model_scene: Node3D = load(body_model_path).instantiate()
		var character_node = player_node.get_node("Character")
		character_node.remove_child(character_node.get_node("Model"))
		character_node.add_child(body_model_scene)
		# 玩家身体服饰节点处理
		if Account.get_player_body_clothe_id({}) != "000" and Account.get_player_body_clothe_id({}) != "":
			var body_clothe_path: String = Account.get_player_body_clothe_path({})
			var _body_clothe_scene: Node3D = load(body_clothe_path).instantiate()
		# 玩家身体武器节点处理
		var attachment_node = player_node.get_node("Character").get_node("Model").get_node("Attachment")
		var attachment_weapon_node = attachment_node.get_node("Weapon")
		attachment_weapon_node.remove_child(attachment_weapon_node.get_child(0))
		if Account.get_player_body_weapon_id({}) != "000" and Account.get_player_body_weapon_id({}) != "":
			var body_weapon_path: String = Account.get_player_body_weapon_path({})
			var body_weapon_scene: Node3D = load(body_weapon_path).instantiate()
			attachment_weapon_node.add_child(body_weapon_scene)
		# 添加最终玩家到地图场景
		map_players_node.add_child(player_node)
		# 添加最终地图场景到游戏
		main.add_child(map_scene)
		await get_tree().create_timer(1.5).timeout
		interface.loading.visible = false
		interface.main.visible = true
		main.visible = true
