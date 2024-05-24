extends Node

const harvester = {
  "max_gold": 5,
  "max_speed": 60,
  "harvest_distance": 1000,
  "harvest_speed": 1,
  "unload_distance": 1000,
}

# globals
func player() -> Node2D:
  var p = get_node("/root/game/player")
  if p:
    return p
  
  return null

func golds() -> Array:
  var golds = get_node("/root/game/golds")
  if golds:
    return golds.get_children()
  
  return []

func bases() -> Array:
  var bases = get_node("/root/game/bases")
  if bases:
    return bases.get_children()
  
  return []
