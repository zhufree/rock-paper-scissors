extends VBoxContainer


var player_select_type:Global.BuffType
#var computer_select_type:Global.BuffType
var can_upgrade:bool = true

signal player_selected(buffType)
signal upgrade_end


func _on_rock_pressed():
	if can_upgrade:
		player_select_type = Global.BuffType.Rock
		%UpgradeSubmit.show()

func _on_paper_pressed():
	if can_upgrade:
		player_select_type = Global.BuffType.Paper
		%UpgradeSubmit.show()

func _on_scissors_pressed():
	if can_upgrade:
		player_select_type = Global.BuffType.Scissors
		%UpgradeSubmit.show()

func _on_upgrade_submit_pressed():
	player_selected.emit(player_select_type)
	can_upgrade = false
	%UpgradeSubmit.set_disabled(true)
	_hide_upgrade()

func _hide_upgrade():
	hide()
	upgrade_end.emit()
