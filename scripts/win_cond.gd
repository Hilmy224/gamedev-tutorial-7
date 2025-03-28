extends Area3D

@export var sceneName := "Win Screen"
@export var nextLevel := "Level"
@export var nextLevel2 := "Level 1"

func _ready():
	print(get_tree().current_scene.name)
	
func _on_body_entered(body):
	print(body.name)
	if body.name == "Player":
		if get_tree().current_scene.name == nextLevel:  
			get_tree().change_scene_to_file("res://scenes/World 1.tscn") 
		elif get_tree().current_scene.name == nextLevel2:  
			get_tree().change_scene_to_file("res://scenes/win_room.tscn") 
