#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name Player extends CharacterBody3D

## 场景资源
@onready var player: Player = $"."
@onready var model: Node3D = $Model
@onready var collision: CollisionShape3D = $Collision
@onready var camera_arm: SpringArm3D = $CameraArm

## 场景数据
@export var player_data: Dictionary
@export var player_control_status: bool
@export var player_speed: float = 3.5 # 玩家移动速度
@export var player_jump_velocity: float = 4.5 # 玩家跳跃速度向量
@export var player_direction: Vector3 # 玩家移动方向

## 如果鼠标事件未被其他场景、节点等资源消耗则触发该函数
func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if (event.button_index == 1 and event.pressed) or (event.button_index == 2 and event.pressed):
			player_control_status = true
		else:
			player_control_status = false

## 准备就绪
func _ready() -> void:
	print("[player]:_ready")
	player_control_status = false

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	# 如果不在地板则进行重力处理
	if not is_on_floor():
		velocity += get_gravity() * _delta
	
	# 在地板且触发跳跃事件时
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = player_jump_velocity
	
	# 获取输入向量
	var input_direction := Input.get_vector("left", "right", "forward", "backward")
	
	# 获取方向
	var _rotation: Quaternion = Quaternion.from_euler(Vector3(0, camera_arm.transform.basis.get_euler().y, 0))
	
	# 移动方向
	player_direction = (_rotation * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if player_direction:
		velocity.x = player_direction.x * player_speed
		velocity.z = player_direction.z * player_speed
		# TODO 动作处理
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)
	
	# 更新玩家朝向
	if abs(velocity.x) + abs(velocity.z) > 0.1:
		var player_current_direction = Vector2(velocity.z, velocity.x)
		var target_quaternion: Quaternion = Quaternion.from_euler(Vector3(0, player_current_direction.angle(), 0))
		model.quaternion = model.quaternion.slerp(target_quaternion, _delta * 10)
	
	# 移动
	move_and_slide()
