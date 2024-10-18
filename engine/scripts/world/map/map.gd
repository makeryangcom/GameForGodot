#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name Map extends Node3D

## 场景资源
@onready var map: Map = $"."
@onready var players: Node3D = $Main/Players
@onready var monsters: Node3D = $Main/Monsters
@onready var npcs: Node3D = $Main/Npcs

## 准备就绪
func _ready() -> void:
	print("[map]:_ready")

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass
