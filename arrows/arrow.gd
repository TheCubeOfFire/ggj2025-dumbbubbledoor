class_name Arrow

extends RigidBody3D

## magnitude of the launch force
@export var initial_force: float

## launch direction of the arrow
@export var initial_direction: Vector3

## multiplier to the bubble explosion force when this is in the radius of an explosion without having caused it
@export var bubble_force_multiplier: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    apply_central_impulse(initial_force * initial_direction.normalized())

func bounce_on_bubble(force: Vector3):
    var speed = linear_velocity.length()
    linear_velocity = Vector3.ZERO
    angular_velocity = Vector3.ZERO
    linear_velocity = speed * force

func push_from_bubble(force: Vector3):
    linear_velocity = Vector3.ZERO
    angular_velocity = Vector3.ZERO
    apply_central_impulse(bubble_force_multiplier * force)
