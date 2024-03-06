extends Button


@export_enum("Rock", "Paper", "Scissors") var card_type:String = "Rock"

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

	cardlevel = num
	$Level.set_text(label_text)

func add_heart():
	if cardlevel >=2:
		_set_card_level(3)
	else:
		_set_card_level(cardlevel+1)

func reduce_heart():
	if cardlevel <= 1:
		_set_card_level(0)
	else:
		_set_card_level(cardlevel-1)

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
