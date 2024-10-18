#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name StateMachine extends Node3D

## 场景数据
@export var state_base: StateBase

## 准备就绪
func _ready() -> void:
	for child in get_children():
		if child is StateBase:
			child.state_machine = self
	await get_parent().ready
	state_base.enter()

## 帧渲染
func _process(delta: float) -> void:
	state_base.process_update(delta)

## 物理帧渲染
func _physics_process(delta: float) -> void:
	state_base.physics_process_update(delta)

## 切换状态
func change_state(target_state_name: String) -> void:
	var target_state = get_node_or_null(target_state_name)
	if target_state == null:
		return
	state_base.exit()
	state_base = target_state
	state_base.enter()
