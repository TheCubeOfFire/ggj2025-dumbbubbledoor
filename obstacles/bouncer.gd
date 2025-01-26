extends StaticBody3D

@export var bounce_force: float

@onready var bounce_anim: AnimationPlayer = $AnimationPlayer

func _on_area_3d_body_entered(body: Node3D) -> void:
	if is_instance_of(body, GeneralRigidbody):
		var force = Vector3(0,0,0)
		var self_position = self.global_position
		var other_position = body.global_position
		force.x = other_position.x - self_position.x
		force.z = other_position.z - self_position.z
		bounce_anim.play("Bounce");
		force.normalized()
		body.apply_central_impulse(force * bounce_force)
