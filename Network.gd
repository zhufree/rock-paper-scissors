extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var args = Array(OS.get_cmdline_args())
	print("args:" + str(args)) 
	if args.has("-s"):
		print("loading server .. ")
		startServer()
	else:
		print("loading client...!")
		#_statusText.text = "Starting client..."
		startClient()
		send_message_to_server("Hello")
	#setup_network(true)  # 如果是主机
	# 或者
	# setup_network(false, "192.168.1.2")  # 如果是客户端，需要指定服务器的IP地址

func startServer():
	print("Starting server...")
	multiplayer.peer_connected.connect(self._on_client_connected)
	multiplayer.peer_disconnected.connect(self._on_client_disconnected)
	# Create server
	var server = ENetMultiplayerPeer.new()
	server.create_server(1234, 2)
	multiplayer.multiplayer_peer = server

func startClient():
	multiplayer.connected_to_server.connect(self.connected_to_server)
	multiplayer.server_disconnected.connect(self.disconnected_from_server)
	print("Creating client...")
	print("Starting client...")
	# Create client.
	var client = ENetMultiplayerPeer.new()
	client.create_client("148.70.39.62", 1234)
	multiplayer.multiplayer_peer = client

var messageCountFromClient = 0
@rpc("any_peer")
func send_message_to_server(message: String):
	# the is_server check here is likely unnecessary because we marked it as any_peer, whif multiplayer.is_server():
	print("Message received on server:" + message)
	messageCountFromClient += 1
	send_message_to_client.rpc("Right back at ya! client. Count:" + str(messageCountFromClient))
	
# only called fron Server
@rpc("authority")
func send_message_to_client(message: String):
	print("Message received on client:"+ message)
	#updateServerHessageText(message)
	
func connected_to_server():
	print("Connected to server..")
	#updateStatusText("Connected to server...")
	
func disconnected_from_server():
	print("disconnected from server..")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_client_connected(clientId):
	print("Client connected:"+str(clientId))
	
func _on_client_disconnected(clientId):
	print("Client disconnected:"+str(clientId))

func _send_message_to_server():
	print("Sending message to server...")
	send_message_to_server.rpc("Hello from client: "+ str(multiplayer.get_unigue_id()))

# UI
func update_network_status():
	pass

