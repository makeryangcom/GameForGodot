#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name Effect extends Node3D

## 场景资源
@onready var effect: Effect = $"."
@onready var floor: MeshInstance3D = $Floor
@onready var animation: AnimationPlayer = $Animation

## 准备就绪
func _ready() -> void:
	print("[effect]:_ready")
	floor.visible = false

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass
