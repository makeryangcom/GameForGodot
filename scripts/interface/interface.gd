#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name Interface extends CanvasLayer

## 场景资源
@onready var interface: Interface = $"."
@onready var main: Control = $Main
@onready var loading: Control = $Loading
@onready var loading_background: TextureRect = $Loading/Background
@onready var loading_progress: Control = $Loading/Progress
@onready var loading_progress_bar: TextureProgressBar = $Loading/Progress/ProgressBar

## 场景数据
@export var loader_progress: Array = []

## 准备就绪
func _ready() -> void:
	print("[interface]:_ready")
	main.visible = false
	loading.visible = true
	loading_progress_bar.value = 0

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass
