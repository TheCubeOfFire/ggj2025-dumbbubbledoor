class_name Bubble

extends RigidBody3D

## multiplier when an explosion from an other bubble pushes this bubble
@export var bubble_push_force_multiplier: float

@onready var _explosion_area_collision: CollisionShape3D = $ExplosionArea/CollisionShape3D

@onready var _mesh: MeshInstance3D = $Mesh

@onready var _bubble_collision: CollisionShape3D = $BubbleCollision

var _arrow_touched: Node3D

var _exploded: bool = false


func _on_body_entered(body: Node) -> void:
    if is_instance_of(body, Arrow) && !_exploded: 
        body.bounce_on_bubble(_compute_explosion_direction(body))
        _arrow_touched = body
        _explosion_area_collision.set_deferred("disabled",false)
        _mesh.visible = false
        _exploded = true
        _bubble_collision.set_deferred("disabled",true)
        var _timer = get_tree().create_timer(0.1)
        await _timer.timeout
        _disappear()


func _on_area_3d_body_entered(body: Node3D) -> void:
    if is_instance_of(body, Bubble) && body != self:
        var force = _compute_explosion_direction(body)
        force *= bubble_push_force_multiplier / self.global_position.distance_to(body.global_position)
        body.push(force)
    elif is_instance_of(body, Arrow) && body != _arrow_touched:
        body.apply_central_impulse(_compute_explosion_direction(body))
        
func _compute_explosion_direction(body: Node3D) -> Vector3:
    var force = Vector3(0,0,0)
    var self_position = self.global_position
    var other_position = body.global_position
    force.x = other_position.x - self_position.x
    force.y = other_position.y - self_position.y
    force.normalized()
    return force

func push(force: Vector3):
    apply_central_impulse(force)

func _disappear():
    _explosion_area_collision.set_deferred("disabled",true)
    queue_free()
