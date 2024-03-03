extends Node

var game_win_mode = 1
var player_client_id = -1
var enemy_client_id = -1
var lobby_name = ""
var players = []

func generate_random_string(length):
	var characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var random_string = ""
	
	for i in range(length):
		var random_index = randi() % characters.length()
		random_string += characters[random_index]

	return random_string
