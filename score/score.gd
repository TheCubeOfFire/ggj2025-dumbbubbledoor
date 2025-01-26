extends Node3D

@onready var zero_mesh: MeshInstance3D = $zero

@onready var one_mesh: MeshInstance3D = $one

@onready var two_mesh: MeshInstance3D = $two

@onready var three_mesh: MeshInstance3D = $three

@export var player := 0;

@onready var activeMesh := zero_mesh;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player == 1 :
		var celShader := activeMesh.get_active_material(0).next_pass as ShaderMaterial
		celShader.set_shader_parameter("player_color", Vector3(0.25,1.9,1.9)) # Replace with function body.
	else:
		var celShader := activeMesh.get_active_material(0).next_pass as ShaderMaterial
		celShader.set_shader_parameter("player_color", Vector3(01.9,0.25,0.25)) 
		$AnimationPlayer.speed_scale = -1.0;
	
func _change_score(new_score : int) -> void:
	if(new_score == 0) :
		return
	
	if(new_score == 1) :
		zero_mesh.visible = false;
		one_mesh.visible = true;
		activeMesh = one_mesh;
		
	elif(new_score == 2) :
		one_mesh.visible = false;
		two_mesh.visible = true;
		activeMesh = two_mesh;
		
	elif(new_score == 3) :
		two_mesh.visible = false;
		three_mesh.visible = true;
		activeMesh = three_mesh;
		
	if player == 1 :
		var celShader := activeMesh.get_active_material(0).next_pass as ShaderMaterial
		celShader.set_shader_parameter("player_color", Vector3(0.25,1.9,1.9)) # Replace with function body.
	else:
		var celShader := activeMesh.get_active_material(0).next_pass as ShaderMaterial
		celShader.set_shader_parameter("player_color", Vector3(01.9,0.25,0.25)) 
	
