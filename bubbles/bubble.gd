class_name Bubble

extends RigidBody3D

@export var push_force_multiplier: float

@onready var _explosion_area_collision: CollisionShape3D = $ExplosionArea/CollisionShape3D


func _on_body_entered(body: Node) -> void:
    if is_instance_of(body, Arrow): 
        _explosion_area_collision.set_deferred("disabled",false)


func _on_area_3d_body_entered(body: Node3D) -> void:
    if is_instance_of(body, Bubble) && body != self:
        var force:  Vector3
        var position = self.global_position
        var other_position = body.global_position
        force.x = other_position.x - position.x
        force.y = other_position.y - position.y
        force.normalized()
        force *= push_force_multiplier / position.distance_to(other_position)
        body.push(force)


func push(force: Vector3):
    apply_central_impulse(force)
