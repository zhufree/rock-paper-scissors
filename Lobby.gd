extends Node2D

@onready var lobby_title_label = %LobbyTitleLabel
@onready var player_info_label = %PlayerInfoLabel
@onready var player_list = %PlayerList
# Called when the node enters the scene tree for the first time.
func _ready():
	player_info_label.text = "Player Name: %s\nPlayer Id: %d" % [GDSync.get_player_data(GDSync.get_client_id(), "Username"),
	GDSync.get_client_id()]
	lobby_title_label.text = "You are in: %s (%d players now)" % [Global.lobby_name, GDSync.get_lobby_player_count()]


func refresh_player_list():
	lobby_title_label.text = "You are in: %s (%d players now)" % [Global.lobby_name, GDSync.get_lobby_player_count()]
	for child in player_list.get_children():
		player_list.remove_child(child)
	for player in Global.players:
		var player_label = Label.new()
		
		player_label.text = "Player %d (%s)" % [player.id, player.username]
		if player.id == GDSync.get_client_id():
			player_label.text += " (you)"
		if player.id == GDSync.get_lobby_data("host"):
			player_label.text += " (host)"
			
		player_list.add_child(player_label)


func _on_timer_timeout():
	refresh_player_list()

func _on_back_button_pressed():
	GDSync.leave_lobby()
	SceneManager.perform_scene_change("res://Index.tscn")


func _on_play_button_pressed():
	SceneManager.perform_scene_change("res://Main.tscn")
