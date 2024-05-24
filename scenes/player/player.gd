extends Node2D

var gold : float = 0
@onready var gold_counter : RichTextLabel = get_node("camera/gold_count")

func _process(delta):
  gold_counter.text = "%d" % int(gold)
