#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends Node

## 数据结构
var data = {
	"token": "test", # 账号Token
	"player": {
		"token": "test123456", # 玩家Token
		"nickname": "小小战士", # 玩家昵称
		"gender": "men", # 玩家性别，可选值men、women
		"career": "warrior", # 玩家职业，可选值warrior、magician、taoist
		"asset": {
			"balance": "0.00", # 玩家账户余额
			"integral": "0", # 玩家积分余额
			"angle": 0, # 玩家朝向角度
			"level": 45, # 玩家等级
			"life": 1200, # 玩家生命值
			"life_max": 1200, # 玩家最大生命值
			"magic": 400, # 玩家最大魔法值
			"magic_max": 400, # 玩家最大魔法值
			"weight": 50, # 玩家负重
			"weight_max": 200, # 玩家最大负重
			"experience": 35000, # 玩家经验值
			"experience_max": 500000, # 玩家最大经验值
		},
		"body": {
			"model": {
				"id": "000", # 玩家模型编号
				"name": "白模", # 玩家模型名称
			},
			"clothe": {
				"id": "000", # 玩家服饰编号
				"name": "无", # 玩家服饰名称
			},
			"weapon": {
				"id": "000", # 玩家武器编号
				"name": "无", # 玩家武器名称
			},
		},
		"map": {
			"id": "001", # 玩家地图编号
			"name": "竞技场", # 玩家地图名称
			"coordinate": { # 玩家地图坐标
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

## 获取玩家身体模型编号数据
func get_player_body_model_id(_player: Dictionary) -> String:
	if _player:
		return _player["body"]["model"]["id"]
	return data["player"]["body"]["model"]["id"]

## 获取玩家身体模型名称数据
func get_player_body_model_name(_player: Dictionary) -> String:
	if _player:
		return _player["body"]["model"]["name"]
	return data["player"]["body"]["model"]["name"]

## 获取玩家身体模型资源路径数据
func get_player_body_model_path(_player: Dictionary) -> String:
	if _player:
		return Base.get_player_body_model_root_path() + get_player_body_model_id(_player) + "/" + get_player_gender(_player) + ".tscn"
	return Base.get_player_body_model_root_path() + get_player_body_model_id(data["player"]) + "/" + get_player_gender(_player) + ".tscn"

## 获取玩身体服饰编号数据
func get_player_body_clothe_id(_player: Dictionary) -> String:
	if _player:
		return _player["body"]["clothe"]["id"]
	return data["player"]["body"]["clothe"]["id"]

## 获取玩家身体服饰名称数据
func get_player_body_clothe_name(_player: Dictionary) -> String:
	if _player:
		return _player["body"]["clothe"]["name"]
	return data["player"]["body"]["clothe"]["name"]

## 获取玩家身体服饰资源路径数据
func get_player_body_clothe_path(_player: Dictionary) -> String:
	if _player:
		return Base.get_player_body_clothe_root_path() + get_player_body_clothe_id(_player) + "/" + get_player_gender(_player) + ".tscn"
	return Base.get_player_body_clothe_root_path() + get_player_body_clothe_id(data["player"]) + "/" + get_player_gender(_player) + ".tscn"

## 获取玩身体武器编号数据
func get_player_body_weapon_id(_player: Dictionary) -> String:
	if _player:
		return _player["body"]["weapon"]["id"]
	return data["player"]["body"]["weapon"]["id"]

## 获取玩家身体武器名称数据
func get_player_body_weapon_name(_player: Dictionary) -> String:
	if _player:
		return _player["body"]["weapon"]["name"]
	return data["player"]["body"]["weapon"]["name"]

## 获取玩家身体武器资源路径数据
func get_player_body_weapon_path(_player: Dictionary) -> String:
	if _player:
		return Base.get_player_body_weapon_root_path() + get_player_body_weapon_id(_player) + "/weapon.tscn"
	return Base.get_player_body_weapon_root_path() + get_player_body_weapon_id(data["player"]) + "/weapon.tscn"

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
