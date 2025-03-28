extends Area3D

@export var sceneName := "Win Screen"
@export var nextLevel := "Level"
@export var nextLevel2 := "Level 1"

	
func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/World 1.tscn") 
