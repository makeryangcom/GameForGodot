#*****************************************************************************
# @author  MakerYang
# @site    www.makeryang.com
#*****************************************************************************

class_name Player extends CharacterBody3D

## 场景资源
@onready var player: Player = $"."
@onready var player_collision: CollisionShape3D = $Collision
@onready var player_character: Node3D = $Character
@onready var player_character_model: Node3D = $Character/Model
@onready var player_camera_arm: SpringArm3D = $CameraArm
@onready var player_camera: PlayerCamera = $CameraArm/Camera
@onready var state_machine: StateMachine = $StateMachine
@onready var player_action_player: AnimationPlayer = $ActionPlayer
@onready var player_action_player_tree: AnimationTree = $ActionPlayerTree
@onready var action_player_tree: AnimationTree = $ActionPlayerTree
@onready var action_player_tree_state: AnimationNodeStateMachinePlayback = action_player_tree.get("parameters/StateMachine/playback")

## 场景数据
@export var player_data: Dictionary
@export var player_speed: float = 1.8 # 玩家移动速度
@export var player_jump_velocity: float = 3.5 # 玩家跳跃速度向量
@export var player_direction: Vector3 # 玩家移动方向dd
@export var player_action_mode: String # 玩家动作模式
@export var player_action: String # 玩家动作
 
## 准备就绪
func _ready() -> void:
	print("[player]:_ready")

## 输入事件
func _input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump") and is_on_floor():
		state_machine.change_state("Jump")

## 帧渲染
func _process(_delta: float) -> void:
	pass

## 物理帧渲染
func _physics_process(_delta: float) -> void:
	# 时间膨胀
	if Input.is_key_pressed(KEY_F):
		Engine.time_scale = 0.2
	else:
		Engine.time_scale = 1.0
	# 如果不在地板则进行重力处理
	if not is_on_floor():
		velocity += get_gravity() * _delta
		if state_machine.state_base.name == "Jump" and state_machine.state_base.name != "Fall":
			state_machine.change_state("Fall")
		
	# 获取输入向量
	var input_direction := Input.get_vector("left", "right", "forward", "backward")
	
	# 获取方向
	var _rotation: Quaternion = Quaternion.from_euler(Vector3(0, player_camera_arm.transform.basis.get_euler().y, 0))
	
	# 移动方向
	player_direction = (_rotation * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if player_direction:
		velocity.x = player_direction.x * player_speed
		velocity.z = player_direction.z * player_speed
		if Input.is_key_pressed(KEY_SHIFT):
			player_speed = 5.0
			state_machine.change_state("Run")
		else:
			player_speed = 1.8
			state_machine.change_state("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)
	
	# 更新玩家朝向
	if abs(velocity.x) + abs(velocity.z) > 0.1:
		var player_current_direction = Vector2(velocity.z, velocity.x)
		var target_quaternion: Quaternion = Quaternion.from_euler(Vector3(0, player_current_direction.angle(), 0))
		player_character.quaternion = player_character.quaternion.slerp(target_quaternion, _delta * 10)
	
	# 移动
	move_and_slide()
