#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends Node

## 数据结构
var data = {
	"version": ProjectSettings.get_setting("application/config/version"),
	"mode": "",
	"path": {
		"map": "res://scenes/world/maps/",
		"player_body_model": "res://scenes/world/players/characters/",
		"player_body_clothe": "res://scenes/world/players/clothes/",
		"player_body_weapon": "res://scenes/world/players/weapons/"
	}
}

## 准备就绪
func _ready() -> void:
	print("[base]:_ready")
	# 限制窗口最小尺寸
	DisplayServer.window_set_min_size(Vector2(1280, 720))
	# 运行模式检测
	if OS.has_feature("dedicated_server"):
		print("[base:mode]:server")
		data["mode"] = "server"
	else:
		print("[base:mode]:client")
		data["mode"] = "client"

## 获取版本信息
func get_version() -> String:
	return data["version"]

## 是否为服务器模式
func is_server() -> bool:
	var server = false
	if data["mode"] == "server":
		server = true
	return server

## 获取玩家身体模型资源根路径
func get_player_body_model_root_path() -> String:
	return data["path"]["player_body_model"]

## 获取玩家服饰模型资源根路径
func get_player_body_clothe_root_path() -> String:
	return data["path"]["player_body_clothe"]

## 获取玩家武器模型资源根路径
func get_player_body_weapon_root_path() -> String:
	return data["path"]["player_body_weapon"]

## 获取地图资源根路径
func get_map_root_path() -> String:
	return data["path"]["map"]
