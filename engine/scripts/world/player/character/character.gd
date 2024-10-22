#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name PlayerCharacter extends Node3D

## 场景资源
@onready var character: PlayerCharacter = $"."
@onready var attachment: BoneAttachment3D = $Attachment
@onready var attachment_weapon: MeshInstance3D = $Attachment/Weapon

## 准备就绪
func _ready() -> void:
	print("[character]:_ready")

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass
