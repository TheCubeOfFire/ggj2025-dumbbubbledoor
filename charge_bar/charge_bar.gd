extends Node3D

@export var color: Vector3

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D


func _ready() -> void:
    var charge_bar_sharder = mesh_instance_3d.get_active_material(0) as ShaderMaterial
    charge_bar_sharder.set_shader_parameter("color", color)
    charge_bar_sharder.set_shader_parameter("charge", 1)



func get_mesh():
    return mesh_instance_3d
