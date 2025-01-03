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
	print("[state:enter]:walk")
	player_node.action_player_tree_state.travel("Walk")

## 帧渲染
func process_update(_delta: float) -> void:
	super.process_update(_delta)

## 物理帧渲染
func physics_process_update(_delta: float) -> void:
	super.physics_process_update(_delta)
	# 退出状态
	if player_node.player_direction == Vector3.ZERO:
		player_node.action_player_tree_state.travel("Idle")
