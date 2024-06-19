extends Area2D

func _input(event):
  if Input.is_action_just_pressed("select_unit"):
    print("harvester clicked: ", event)
