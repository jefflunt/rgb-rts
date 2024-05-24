extends Node2D

var base : Node2D
var gold : Node2D
var carrying_gold : float = 0
@export var debug : bool
@onready var state : int = states.idle

enum states {
  idle = 0,
  travel_to_base = 1,
  travel_to_gold = 2,
  harvesting = 3,
  unloading = 4,
}

@onready var debug_msg : RichTextLabel = get_node("debug_msg")

func _ready():
  var all_golds = G.golds()
  if all_golds:
    for g in all_golds:
      if !gold:
        gold = g
      elif position.distance_squared_to(g.position) < position.distance_squared_to(gold.position):
        gold = g
  
  var all_bases = G.bases()
  if all_bases:
    for b in all_bases:
      if !base:
        base = b
      elif position.distance_squared_to(b.position) < position.distance_squared_to(base.position):
        base = b

func _process(delta):
  debug_msg.text = "%s (%s, %s)\n(%d, %d)\n%d" % [state, gold != null, base != null, int(position.x), int(position.y), int(carrying_gold)]
  debug_msg.visible = debug

func _physics_process(delta):
  match state:
    states.idle:
      visible = true
      if gold:
        if carrying_gold < G.harvester.max_gold:
          state = states.travel_to_gold
        elif base:
          state = states.travel_to_base
    states.travel_to_base:
      var direction_to_base = (base.position - position).normalized()
      position += direction_to_base * delta * G.harvester.max_speed
      
      var distance_to_base = position.distance_squared_to(base.position)
      if distance_to_base < G.harvester.unload_distance:
        state = states.unloading
    states.travel_to_gold:
      var direction_to_gold = (gold.position - position).normalized()
      position += direction_to_gold * delta * G.harvester.max_speed
      
      var distance_to_gold = position.distance_squared_to(gold.position)
      if distance_to_gold < G.harvester.harvest_distance:
        state = states.harvesting
    states.harvesting:
      visible = false
      if carrying_gold >= G.harvester.max_gold:
        state = states.idle
        carrying_gold = G.harvester.max_gold
      else:
        carrying_gold += delta * G.harvester.harvest_speed
    states.unloading:
      if carrying_gold <= 0.0:
        state = states.idle
        carrying_gold = 0.0
      else:
        var gold_transfer = delta * G.harvester.harvest_speed
        carrying_gold -= gold_transfer
        G.player().gold += gold_transfer

