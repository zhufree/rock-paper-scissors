extends Node2D
signal update_network_status(message)
@onready var network_status_label = %NetworkStatusLabel

var status = "Connecting..."
# Called when the node enters the scene tree for the first time.
func _ready():
	GDSync.connected.connect(connected)
	GDSync.connection_failed.connect(connection_failed)
	GDSync.client_joined.connect(client_joined)
	GDSync.client_left.connect(client_left)
	GDSync.disconnected.connect(disconnected)
	GDSync.lobbies_received.connect(public_lobbies_received)
	GDSync.start_multiplayer()
	

func connected():
	Global.player_client_id = GDSync.get_client_id()
	var username = Global.generate_random_string(6)
	GDSync.set_player_username(username)
	status = "You are now connected as Player%s(%s)!\n" % [GDSync.get_client_id(), username]
	_update_network_status()
	
	for id in GDSync.get_all_clients():
		client_joined(id)

func connection_failed(error : int):
	match(error):
		ENUMS.CONNECTION_FAILED.INVALID_PUBLIC_KEY:
			push_error("The public or private key you entered were invalid.")
		ENUMS.CONNECTION_FAILED.TIMEOUT:
			push_error("Unable to connect, please check your internet connection.")


func disconnected():
	pass

func client_joined(client_id : int):
#	Instantiate a player
	var player_exist = false
	for player in Global.players:
		if player.id == client_id:
			player_exist = true
			break
	if not player_exist:
		var player = {
			'id': client_id,
			'username': GDSync.get_player_data(client_id, "Username")
		}
		Global.players.append(player)
	_update_network_status()


func client_left(client_id : int):
	#status += "Player %d left!" %client_id
	Global.players = Global.players.filter(
		func(dict): return dict.get("id", -1) != client_id
	)


func public_lobbies_received(lobbies: Array):
	print(lobbies)
	
# 在任何节点的脚本中
func _finalize():
	print("游戏准备退出")
	GDSync.leave_lobby()
			
func _update_network_status():
	network_status_label.text = status
