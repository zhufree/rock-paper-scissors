@tool
extends HBoxContainer


@export var is_player:bool = false

var can_select:bool = false
var selected_card_type:Global.BuffType
var current_score:int = 0


signal selected_card(type:Global.BuffType)
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
		_select_card(Global.BuffType.Rock)

func _on_paper_button_pressed():
	if is_player and can_select:
		_select_card(Global.BuffType.Paper)

func _on_scissors_button_pressed():
	if is_player and can_select:
		_select_card(Global.BuffType.Scissors)

func _select_card(type:Global.BuffType):
	can_select = false
	selected_card_type = type
	selected_card.emit(type)

func _reset_select():
	can_select = true
	selected_card_type = Global.BuffType.None
	reselect_card.emit()

#func _on_upgrade_computer_selected(buffType):
	#if not is_player:
		#_upgrade_card(buffType)
		#print("computer upgrade: ", buffType)

func _on_upgrade_player_selected(buffType):
	if is_player:
		_upgrade_card(buffType)
		print("player upgrade: ", buffType)
		
func _upgrade_card(buffType:Global.BuffType):
	for node in $CardContainer.get_children():
		if node.card_type == buffType:
			node.add_heart()
			print("upgrade signal: ", node, " heart: ", node.cardlevel)

func _on_upgrade_upgrade_end():
	propagate_call("_on_reselect_card")
	can_select = true


func _on_main_computer_win():
	_add_score()


func _on_main_player_win():
	_add_score()

func _add_score():
	var score = 1
	for node in $CardContainer.get_children():
		if node.card_type == selected_card_type:
			score = node.cardlevel  * 10
	current_score = current_score + score
	$LabelContainer/Label.set_text("score: %d" % [current_score])
