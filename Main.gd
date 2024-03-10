extends Node2D


#const game_win_mode_max_count = [1, 3, 5]
#const choices = [{
	#'id': 'rock',
	#'res' : "res://assets/images/rock.png"
#}, {
	#'id': 'paper',
	#'res': "res://assets/images/paper.png"
#}, {
	#'id': 'scissors',
	#'res': "res://assets/images/scissors.png"
#}]
#const countdown_frames = [
	#preload("res://assets/images/1.png"),
	#preload("res://assets/images/2.png"),
	#preload("res://assets/images/3.png")
#]
#const win_icon = preload("res://assets/images/win.png")
#const lose_icon = preload("res://assets/images/lose.png")
#const draw_icon = preload("res://assets/images/draw.png")
#const vistory_icon = preload("res://assets/images/victory.png")
#const defeat_icon = preload("res://assets/images/defeat.png")
#var total_play_counts = 0
#var player_win_count = 0
#var enemy_win_count = 0
#var draw_count = 0
var current_player_choice:Global.BuffType = Global.BuffType.None
var current_computer_choice:Global.BuffType = Global.BuffType.None


@onready var player_choice_texture = %PlayerChoiceTexture
@onready var player_load_anim = %LoadAnim
@onready var result_load_timer = %ResultLoadTimer

@onready var result_texture = %ResultTexture
@onready var statistics_label_2 = %StatisticsLabel2
@onready var restart_button = %RestartButton


signal player_win
signal computer_win


func _ready():
	#statistics_label_2.text = "%d : %d(%s max)" % [0,0, game_win_mode_max_count[Global.game_win_mode-1]]
	pass
	
#func get_random_choice():
	#var rand_index = randi() % 3
	#return [rand_index, choices[rand_index]]

#func press_choice(index):
	#current_player_choice = index
	#player_load_anim.play("load")
	#result_texture.texture = countdown_frames[countdown-1]
	#result_load_timer.start()
#
#var loop_count = 0  # 当前循环次数
#var max_loops = 5  # 你想要循环的次数

#func _on_player_load_anim_animation_finished(anim_name):
	#loop_count += 1
	#if loop_count < max_loops:
		#player_load_anim.play(anim_name)  # 重新播放动画
	#else:
		#loop_count = 0  # 重置循环次数
		#_on_load_anim_finished()  # 调用循环结束的回调函数

func _on_load_anim_finished():
	var index = current_player_choice
	#player_choice_texture.texture = load(choices[index]['res'])
	#var result  = get_random_choice()
	var program_index = current_computer_choice
	#var result_item = result[1]
	#total_play_counts += 1
	
	#if index != 2 and index > program_index:
		#result_texture.texture = win_icon
		#player_win_count += 1
	#elif index == 2 and program_index == 1:
		#result_texture.texture = win_icon
		#player_win_count += 1
	#elif index == 0 and program_index == 2:
		#result_texture.texture = win_icon
		#player_win_count += 1
	#elif index == program_index:
		#result_texture.texture = draw_icon
		#draw_count += 1
	#else:
		#result_texture.texture = lose_icon
		#enemy_win_count += 1
	#if player_win_count == Global.game_win_mode:
		#result_texture.texture = vistory_icon
		#restart_button.show()
	#elif enemy_win_count == Global.game_win_mode:
		#result_texture.texture = defeat_icon
		#restart_button.show()

	# r1p2s3 index - program  win: 1 or -2 lose: -1 or 2
	if index - program_index == 1 or index - program_index == -2:
		player_win.emit()
		print("player win")
	else:
		computer_win.emit()
		print("computer win")

	#LobbyLabel.text = "Winning Rate: %f" % (float(player_win_count)/total_play_counts)
	#statistics_label_2.text = "%d : %d (%s max)" % [player_win_count, enemy_win_count, game_win_mode_max_count[Global.game_win_mode-1]]
	#statistics_label_2.text = "Winning Counts: %d/%d" % [player_win_count, total_play_counts]
#
#var countdown = 3
#
#func _on_result_load_timer_timeout():
	#countdown -= 1
	#if countdown == 1:
		#result_load_timer.one_shot = true
		#result_texture.texture = countdown_frames[countdown-1]
	#elif countdown == 0:
		#result_load_timer.stop()
		#result_load_timer.one_shot = false
		#countdown = 3
	#else:
		#result_texture.texture = countdown_frames[countdown-1]
#
#func _on_restart_button_pressed():
	#player_win_count = 0
	#enemy_win_count = 0
	#draw_count = 0
	#statistics_label_2.text = "%d : %d(%s max)" % [0,0, game_win_mode_max_count[Global.game_win_mode-1]]
	#restart_button.hide()
	#result_texture.texture = null

func _on_player_score_selected_card(type):
	current_player_choice = type
	if current_computer_choice != Global.BuffType.None:
		_calculate()

func _on_computer_score_selected_card(type):
	current_computer_choice = type
	if current_player_choice != Global.BuffType.None:
		_calculate()

func _calculate():
	_on_load_anim_finished()
	current_computer_choice = Global.BuffType.None
	current_player_choice = Global.BuffType.None
