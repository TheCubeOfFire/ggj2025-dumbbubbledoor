class_name GeneralRigidbody

extends RigidBody3D

## x kill plane
@export var max_x: float = 300

## z kill plane
@export var max_z: float = 300

## magnitude of the launch force
@export var initial_force: float

## launch direction of the arrow
@export var initial_direction: Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    apply_central_impulse(initial_force * initial_direction.normalized())
    
    
func _physics_process(delta: float) -> void:
    if(abs(global_position.x) > max_x || abs(global_position.z) > max_z):
        queue_free()
