#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name StateBase extends Node3D

## 场景数据
var state_machine: StateMachine

## 进入状态
func enter() -> void:
	pass

## 退出状态
func exit() -> void:
	pass

## 帧渲染
func process_update(_delta: float) -> void:
	pass

## 物理帧渲染
func physics_process_update(_delta: float) -> void:
	pass
