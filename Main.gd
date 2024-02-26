extends Node2D

var choices = ['rock', 'paper', 'scissors']
var total_play_counts = 0
var win_counts = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_random_choice():
	var rand_index = randi() % 3
	return [rand_index, choices[rand_index]]
	
func press_choice(index):
	$ColorRect/HBoxContainer/VBoxContainer/PlayerContainer/PlayerChoiceLabel.text = choices[index]
	var result  = get_random_choice()
	var program_index = result[0]
	var program_str = result[1]
	$ColorRect/HBoxContainer/VBoxContainer3/EnemyContainer/EnemyChoiceLabel.text = program_str
	total_play_counts += 1
	var result_label = $ColorRect/HBoxContainer/VBoxContainer2/ResultContainer/ResultLabel
	if index != 2 and index > program_index:
		result_label.text = 'You Win!'
		win_counts += 1
	elif index == 2 and program_index == 1:
		result_label.text = 'You Win!'
		win_counts += 1
	elif index == 0 and program_index == 2:
		result_label.text = 'You Win!'
		win_counts += 1
	elif index == program_index:
		result_label.text = 'Draw!'
	else:
		result_label.text = 'You Lose!'
	$ColorRect/HBoxContainer/VBoxContainer2/StatisticsContainer/StatisticsLabel1.text = "Winning Rate: %f" % (float(win_counts)/total_play_counts)
	$ColorRect/HBoxContainer/VBoxContainer2/StatisticsContainer/StatisticsLabel2.text = "Winning Counts: %d/%d" % [win_counts, total_play_counts]
