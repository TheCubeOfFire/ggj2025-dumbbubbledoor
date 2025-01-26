class_name Arrow

extends GeneralRigidbody

## max speed for the arrows
@export var max_speed: float

## multiplier to the bubble explosion force when this is in the radius of an explosion without having caused it
@export var bubble_force_multiplier: float

@export var is_active = false

@onready var arrow_mesh: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
    super()
    if(player == 0):
        var celShader := arrow_mesh.get_active_material(0).next_pass as ShaderMaterial
        celShader.set_shader_parameter("player_color", Vector3(0.25,1.9,1.9))
    else :
        var celShader := arrow_mesh.get_active_material(0).next_pass as ShaderMaterial
        celShader.set_shader_parameter("player_color", Vector3(1.9,0.25,0.25))
        
func bounce_on_bubble(force: Vector3):
    var speed = linear_velocity.length()
    linear_velocity = Vector3.ZERO
    angular_velocity = Vector3.ZERO
    linear_velocity = speed * force

func push_from_bubble(force: Vector3, explosion_point: Vector3):
    apply_central_impulse(bubble_force_multiplier * force / explosion_point.distance_to(self.global_position))


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
    var norm = min(max_speed, state.linear_velocity.length())
    state.linear_velocity = state.linear_velocity.normalized() * norm

func _process(_delta) -> void:
    arrow_mesh.rotate_x(1.0*_delta)
    
