extends Button

@export var card_type:Global.BuffType = Global.BuffType.None


var cardlevel: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if shortcut:
		$Shortcut_tips.set_text(shortcut.get_as_text())
	_set_card_level(cardlevel)

func _on_player():
	$Shortcut_tips.show()

func _on_computer():
	shortcut = null

func _set_card_level(num:int):
	var label_text = ""
	var is_heart = "[color=#ee0000]♥[/color]"
	var not_heart = "[color=#cccccc]♥[/color]"

	for i in range(num):
		label_text += is_heart
	for i in range(3-num):
		label_text += not_heart

	$Level.set_text(label_text)

# 超过3不会增加等级，但会被记录
func add_heart():
	if cardlevel >=2:
		_set_card_level(3)
	else:
		_set_card_level(cardlevel+1)
	cardlevel = cardlevel + 1

# 不会出现低于0的情况
func reduce_heart():
	if cardlevel <= 1:
		cardlevel = 0
		_set_card_level(0)
	else:
		cardlevel = cardlevel - 1
		_set_card_level(cardlevel)

func _on_selected_card(type):
	if (type==card_type):
		print(card_type)
		$Select.show()
	else:
		set_disabled(true)

func _on_reselect_card():
	$Select.hide()
	set_disabled(false)
	print('reselect')
