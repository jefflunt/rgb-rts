extends Node2D

var input_action_state = {
  "select_unit": false
}

func _unhandled_input(event):
  pass
  #if Input.is_action_just_pressed("select_unit") && !input_action_state.select_unit:
    #input_action_state.select_unit = true
    #print("select_unit action triggered")
  #elif Input.is_action_just_released("select_unit"):
    #input_action_state.select_unit = false
