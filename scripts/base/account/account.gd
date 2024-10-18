#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends Node

## 数据结构
var data = {
	"token": "test",
	"player": {
		"token": "test123456",
		"nickname": "小小战士",
		"gender": "men",
		"career": "warrior",
		"asset": {
			"balance": "0.00",
			"integral": "0",
			"angle": 0,
			"level": 45,
			"life": 1200,
			"life_max": 1200,
			"magic": 400,
			"magic_max": 400,
			"weight": 50,
			"weight_max": 200,
			"experience": 35000,
			"experience_max": 500000,
		},
		"body": {
			"clothe": "000"
		},
		"map": {
			"id": "001",
			"name": "竞技场",
			"coordinate": {
				"x": 0,
				"y": 0,
				"z": 0
			}
		}
	}
}

## 获取账户Token信息
func get_token() -> String:
	return data["token"]

## 获取玩家信息
func get_player() -> Dictionary:
	return data["player"]

## 更新并返回玩家信息
func update_player(player: Dictionary) -> Dictionary:
	data["player"] = player
	return data["player"]

## 获取玩家Token信息
func get_player_token(_player: Dictionary) -> String:
	if _player:
		return _player["token"]
	return data["player"]["token"]

## 获取玩家昵称数据
func get_player_nickname(_player: Dictionary) -> String:
	if _player:
		return _player["nickname"]
	return data["player"]["nickname"]

## 获取玩家性别数据
func get_player_gender(_player: Dictionary) -> String:
	if _player:
		return _player["gender"]
	return data["player"]["gender"]

## 获取玩家职业数据
func get_player_career(_player: Dictionary) -> String:
	if _player:
		return _player["career"]
	return data["player"]["career"]

## 获取玩家地图编号数据
func get_player_map_id(_player: Dictionary) -> String:
	if _player:
		return _player["map"]["id"]
	return data["player"]["map"]["id"]

## 获取玩家地图名称数据
func get_player_map_name(_player: Dictionary) -> String:
	if _player:
		return _player["map"]["name"]
	return data["player"]["map"]["name"]

## 获取玩家地图资源路径数据
func get_player_map_path(_player: Dictionary) -> String:
	if _player:
		return Base.get_map_root_path() + get_player_map_id(_player) + "/map.tscn"
	return Base.get_map_root_path() + get_player_map_id(data["player"]) + "/map.tscn"
