extends Node3D

const BUBBLE: PackedScene = preload("res://bubbles/Bubble.tscn")

@export_node_path("Node3D") var bubble_container_node_path := ^""

## min launch force
@export var min_force: float
## max launch force
@export var max_force: float

## min bubble interval
@export var min_interval: float
## max bubble interval
@export var max_interval: float

## launch angle min
@export var _initial_direction_min: Vector3
## launch angle max
@export var _initial_direction_max: Vector3

@onready var _bubble_container_node := get_node(bubble_container_node_path) as Node3D
@onready var _player: Player = $"../../Players/LeftPlayer"

@onready var timer: Timer = $Timer

var min_spawn_position: Vector3
var max_spawn_position: Vector3
var spawn_y: float


func _ready() -> void:
    min_spawn_position = global_position - (scale/2)
    max_spawn_position = global_position + (scale/2)
    spawn_y = _player.get_spawn_pos().y
    _reset_timer()

func _gen_random_pos():
    var x = randf_range(min_spawn_position.x, max_spawn_position.x)
    var z = randf_range(min_spawn_position.z, max_spawn_position.z)
    var y = spawn_y
    return Vector3(x, y, z)
    
func _gen_random_angle():
    var x = randf_range(_initial_direction_min.x, _initial_direction_max.x)
    var z = randf_range(_initial_direction_min.z, _initial_direction_max.z)
    return Vector3(x, 0, z)


func _on_timer_timeout() -> void:
    var new_projectile := BUBBLE.instantiate()
    if is_instance_of(new_projectile, Bubble):
        new_projectile.initial_force = randf_range(min_force, max_force)
        new_projectile.initial_direction = _gen_random_angle()
        var type = randf_range(0, Bubble.BubbleTypes.size())
        new_projectile.bubble_type = type
    _bubble_container_node.add_child(new_projectile)
    new_projectile.global_position = _gen_random_pos()
    _reset_timer()


func _reset_timer():
    timer.wait_time = randf_range(min_interval, max_interval)
    timer.start()
