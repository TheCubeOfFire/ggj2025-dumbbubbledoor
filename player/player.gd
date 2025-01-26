class_name Player
extends Node3D


const INITIAL_BUBBLE_IMPULSE: float = 22.5
const INITIAL_ARROW_IMPULSE: float = 30.0


const ARROW: PackedScene = preload("res://arrows/Arrow.tscn")
const BUBBLE: PackedScene = preload("res://bubbles/Bubble.tscn")

@export var controller_index : int : 
    set(value) : 
        print(value)
        _controller_index = value	
        if (value == 0) :
            var shaderMat := shoot_direction_mesh.get_active_material(0) as ShaderMaterial
            shaderMat.set_shader_parameter("player_color", Vector3(0.25,1.9,1.9))
    get : 
        return _controller_index
        
@export var flipped := false
@export var player_id := 0

@export_range(0, 10000, 0.1, "suffix:deg/s") var angular_speed := 80
@export_range(0, TAU, 1, "radians_as_degrees") var angle_limit := deg_to_rad(80)

@export_range(0, 100, 0.01, "suffix:s") var arrow_cooldown := 2.0

@export_node_path("Node3D") var bubble_container_node_path := ^""
@export_node_path("Node3D") var arrow_container_node_path := ^""
@export_node_path("Node3D") var charge_bar := ^""

@export var is_game_over = false

var _controller_index := -1 

var _default_rotation := PI if flipped else 0.0
var _current_rotation := 0.0

var _bubble_count_in_spawn := 0
var _arrow_count_in_spawn := 0

var _current_cooldown := 0.0
var charge_bar_sharder: ShaderMaterial


@onready var _direction_pivot := $DirectionPivot as Marker3D

@onready var _arrow_container_node := get_node(arrow_container_node_path) as Node3D
@onready var _bubble_container_node := get_node(bubble_container_node_path) as Node3D
@onready var shoot_direction_mesh: MeshInstance3D = $DirectionPivot/ShootDirectionMesh


func _ready() -> void:
    _direction_pivot.rotation.y = _default_rotation

func get_spawn_pos():
    return _direction_pivot.global_position
    
func _physics_process(delta: float) -> void:
    if _controller_index < 0 || _controller_index >= InputManager.get_player_count() || is_game_over:
        return

    if _current_cooldown > 0.0:
        _current_cooldown -= delta
        var charge = (arrow_cooldown - _current_cooldown)/arrow_cooldown
        charge_bar_sharder = get_node(charge_bar).get_mesh().get_active_material(0) as ShaderMaterial
        charge_bar_sharder.set_shader_parameter("charge", charge)

    _update_player_rotation()
    _process_shoot_events()


func _update_player_rotation() -> void:
    var up_action := InputManager.InputActionType.ANGLE_DOWN if flipped else InputManager.InputActionType.ANGLE_UP
    var down_action := InputManager.InputActionType.ANGLE_UP if flipped else InputManager.InputActionType.ANGLE_DOWN

    var angle_input := InputManager.get_axis_for_player(_controller_index, down_action, up_action)
    _current_rotation += angle_input * deg_to_rad(angular_speed) * get_physics_process_delta_time()
    _current_rotation = clampf(_current_rotation, -angle_limit, angle_limit)

    _direction_pivot.rotation.y = _default_rotation + _current_rotation


func _process_shoot_events() -> void:
    if _is_input_just_pressed(InputManager.InputActionType.SHOOT_BUBBLE):
        _shoot_projectile(BUBBLE, INITIAL_BUBBLE_IMPULSE, _bubble_container_node)


    if _is_input_just_pressed(InputManager.InputActionType.SHOOT_ARROW):
        if _current_cooldown <= 0.0:
            _current_cooldown = arrow_cooldown
            _shoot_projectile(ARROW, INITIAL_ARROW_IMPULSE, _arrow_container_node)

func _shoot_projectile(projectile_scene: PackedScene, initial_impulse: float, projectile_container: Node3D) -> void:
    var new_projectile := projectile_scene.instantiate()
    if is_instance_of(new_projectile, GeneralRigidbody):
        new_projectile.player = _controller_index
        new_projectile.initial_force = initial_impulse
        new_projectile.initial_direction = _direction_pivot.global_transform.basis.x
    projectile_container.add_child(new_projectile)
    new_projectile.global_position = _direction_pivot.global_position


func _is_input_just_pressed(input_type: InputManager.InputActionType) -> bool:
    return InputManager.is_action_just_pressed_for_player(_controller_index, input_type)


func _on_spawn_area_body_entered(body: Node3D) -> void:
    if is_instance_of(body, Bubble):
        _bubble_count_in_spawn += 1
    elif is_instance_of(body, Arrow):
        _arrow_count_in_spawn += 1


func _on_spawn_area_body_exited(body: Node3D) -> void:
    if is_instance_of(body, Bubble):
        _bubble_count_in_spawn -= 1
    elif is_instance_of(body, Arrow):
        _arrow_count_in_spawn -= 1
