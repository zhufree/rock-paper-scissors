extends Node


signal selected_upgrade
signal selected_card

func random_card(type):
	var types = [1,2,3].filter(func(item):return item!=type)
	#var selected = Global.BuffType.keys()[types[randi() % 2]]
	var selected = types[randi() % 2]
	return selected

func _on_upgrade_player_selected(buffType):
	$ComputerScore._upgrade_card(random_card(buffType))

func _on_upgrade_upgrade_end():
	#$ComputerScore._select_card(randi() % 3)
	pass


func _on_player_score_selected_card(type):
	$ComputerScore._select_card(random_card(type))
