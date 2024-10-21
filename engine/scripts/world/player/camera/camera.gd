#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name PlayerCamera extends Camera3D

## 场景资源
@onready var camera: Camera3D = $"."
@onready var camera_arm: SpringArm3D = $".."

## 场景数据
@export var arm_x: float = 0 # 弹簧臂的x轴的旋转欧拉角
@export var arm_y: float = 0 # 弹簧臂的y轴的旋转欧拉角
@export var arm_x_speed: float = 5 # 弹簧臂X轴旋转速度
@export var arm_y_speed: float = 5 # 弹簧臂Y轴旋转速度

@export_range(0, 80) var camera_min_limit_angle: float = 0 # 相机与地面的最小夹角角度
@export_range(10, 85) var camera_max_limit_angle: float = 90 # 相机与地面的最大夹角角度

@export var camera_distance: float = 7 # 相机的视距
@export var camera_min_distance: float = 4 # 相机的最小视距
@export var camera_max_distance: float = 10 # 相机的最大视距
@export var camera_distance_speed: float = 80 # 相机视角缩放速度
@export var camera_is_need_damping: bool = true # 相机视角是否启动阻尼
@export var camera_need_damping: float = 10 # 相机视角阻尼大小

var mouse_right_pressed: bool = false # 鼠标右键是否按下

# 鼠标滑动的状态枚举
enum MOUSE_WHEEL_STATE {
	NONE = 0, # 未滑动
	UP = -1, # 向前滑动
	DOWN = 1, # 向后滑动
}
var mouse_wheel: MOUSE_WHEEL_STATE = MOUSE_WHEEL_STATE.NONE # 鼠标的滚轮状态

## 输入事件
func _input(event: InputEvent) -> void:
	# 判断当前事件是否为鼠标移动且鼠标右键被按下，来更新x,y的值
	if event is InputEventMouseMotion and mouse_right_pressed:
		# 鼠标上下位移，调整的是视野上下移动，此时旋转的是x轴
		arm_x = arm_x + -event.relative.y * arm_x_speed * 0.001
		# 鼠标左右移动，调整的是视野的左右移动，旋转的是y轴
		arm_y = arm_y + -event.relative.x * arm_x_speed * 0.001
		# 根据视角角度边界，来限制x的值
		var x_min_limit = camera_min_limit_angle / 180 * PI # -3.14到+3.14
		var x_max_limit = camera_max_limit_angle / 180 * PI
		arm_x = -clamp(-arm_x, x_min_limit, x_max_limit) # 限制x
		
## 准备就绪
func _ready() -> void:
	print("[camera]:_ready")
	# 初始化弹簧臂的x、y值
	arm_x = camera_arm.transform.basis.get_euler().x
	arm_y = camera_arm.transform.basis.get_euler().y

## 帧渲染
func _process(_delta: float) -> void:
	update_mouse_input()
	# 根据已有的欧拉角，来获取3D旋转的单位四元数
	var _rotation: Quaternion = Quaternion.from_euler(Vector3(arm_x , arm_y, 0))
	# 根据滚轮事件，来调整视距
	camera_distance += mouse_wheel * camera_distance_speed * _delta
	# 限定camera_distance长短，不越界
	camera_distance = clamp(camera_distance, camera_min_distance, camera_max_distance)
	# 判断是都需要阻尼
	if camera_is_need_damping:
		# 使用slerp方法，来逐帧调整数值
		camera_arm.quaternion = camera_arm.quaternion.slerp(_rotation, _delta * camera_need_damping)
		# 使用lerp方法，来逐帧调整数值
		camera_arm.spring_length = lerp(camera_arm.spring_length, camera_distance, _delta * camera_need_damping)
	else:
		camera_arm.quaternion = _rotation
		camera_arm.spring_length = camera_distance

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	pass

## 更新鼠标输入
func update_mouse_input() -> void:
	# 判断鼠标有没有按下右键
	mouse_right_pressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	# 判断鼠标是否前滑
	var is_wheel_up = Input.is_action_just_released("mouse_scroll_up")
	# 判断鼠标是否后滑
	var is_wheel_down = Input.is_action_just_released("mouse_scroll_down")
	if is_wheel_up:
		mouse_wheel = MOUSE_WHEEL_STATE.UP
	elif is_wheel_down:
		mouse_wheel = MOUSE_WHEEL_STATE.DOWN
	else:
		mouse_wheel = MOUSE_WHEEL_STATE.NONE
