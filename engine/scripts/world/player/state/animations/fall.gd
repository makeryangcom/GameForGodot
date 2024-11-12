#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends StateBase

## 场景数据
@export var player_node: Player

## 进入状态
func enter() -> void:
	super.enter()
	print("[state:enter]:fall")

## 帧渲染
func process_update(_delta: float) -> void:
	super.process_update(_delta)

## 物理帧渲染
func physics_process_update(_delta: float) -> void:
	super.physics_process_update(_delta)
	if player_node.is_on_floor():
		player_node.action_player_tree_state.travel("Idle")
