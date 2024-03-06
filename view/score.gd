@tool
extends HBoxContainer

@export var is_player:bool = false

var can_select:bool = true
var selected_card_type:String = ""

signal selected_card(type:StringName)
signal reselect_card

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_player:
		$LabelContainer.set_alignment(2)
		move_child($LabelContainer, 0)
		if not Engine.is_editor_hint():
			propagate_call("_on_player")
		#for node in $CardContainer.get_children():
			#if node.has_method("_on_player"):
				#node._on_player()
	else:
		$LabelContainer.set_alignment(0)
		if not Engine.is_editor_hint():
			propagate_call("_on_computer")

# 只有Player能按button，Player只能按自己的Button
func _on_rock_button_pressed():
	if is_player and can_select:
		_select_card("Rock")

func _on_paper_button_pressed():
	if is_player and can_select:
		_select_card("Paper")

func _on_scissors_button_pressed():
	if is_player and can_select:
		_select_card("Scissors")

func _select_card(type:String):
	can_select = false
	selected_card.emit(type)
	selected_card_type = type
	
func _reset_select():
	can_select = true
	reselect_card.emit()
	selected_card_type = ""
