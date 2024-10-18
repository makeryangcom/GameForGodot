#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends Control

## 场景资源
@onready var launch: Control = $"."

## 场景预加载资源
@onready var world_scenes: PackedScene = preload("res://scenes/world/world.tscn")

## 准备就绪
func _ready() -> void:
	print("[launch]:_ready")
	await get_tree().create_timer(2).timeout
	on_enter_world_scene()

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass

## 进入世界场景
func on_enter_world_scene() -> void:
	print("[launch]:on_enter_world_scene")
	get_tree().change_scene_to_packed(world_scenes)
