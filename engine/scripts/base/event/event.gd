#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

extends Control

## 数据结构
var data = {
	"in_viewport": false
}

## 输入事件检测
func _input(event) -> void:
	# 获取窗口的边界
	var viewport_rect = get_viewport_rect()
	# 获取鼠标的位置
	var viewport_mouse_position = get_viewport().get_mouse_position()
	# 如果鼠标在窗口区域内
	if viewport_rect.has_point(viewport_mouse_position):
		data["in_viewport"] = true
		# 键盘输入事件
		if event is InputEventKey:
			pass
		# 鼠标输入事件
		if event is InputEventMouseButton:
			pass
	else:
		data["in_viewport"] = false

## 获取鼠标是否在窗口区域内
func is_in_viewport() -> bool:
	return data["in_viewport"]
