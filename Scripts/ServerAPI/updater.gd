extends Control
var intro_played = false
var file = File.new()

func _ready() -> void:
#		var player = OS.native_video_play("res://assets/Animations/intro.webm",0,"1","1")
#		print(str(player))
	file = File.new()
#	print(str(PI))
#	if Globals.release_mode:
#		load_assets()
#	ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_DOWNLOADING_DATA)
#	BackgroundLoad.load_scene("res://s.tscn")
	var dir = Directory.new()
	dir.open('user://')
	dir.make_dir('dlcs')
	if not file.file_exists('user://logs/engine_log.txt'):
		dir = Directory.new()
		dir.open('user://')
		dir.make_dir('logs')
	OS.request_permissions()
	
#	$icon.show()
	$Timer.start()
	$VideoPlayer.stop()
	#OS.native_video_play("res://assets/Animations/intro2.mp4",0, "", "" )
	
#	if intro_played:
#		get_tree().change_scene("res://Scenes/Menu.tscn")
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_VideoPlayer_finished()
func _on_AnimationPlayer_animation_finished(_anim_name):
	if not str(OS.get_name()) == "Android":
		var stream = VideoStreamGDNative.new()
		var file = "res://assets/Animations/intro_vp8.webm"#supports for now
		print(file)
		stream.set_file(file)
		var vp = $VideoPlayer
		vp.stream = stream
		var sp = vp.stream_position
		# hack: to get the stream length, set the position to a negative number
		# the plugin will set the position to the end of the stream instead.
		vp.stream_position = -1
		var duration = vp.stream_position
	#	$ProgressBar.max_value = duration
		vp.stream_position = sp
		vp.play()
		yield($VideoPlayer,"finished")
	_on_VideoPlayer_finished()
###DLC DOWNLOADING


func _on_VideoPlayer_finished():
	if not get_tree().change_scene('res://Scenes/Menu.tscn'):
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_GAME_DATA)


func _on_pck_request_completed(result, response_code, headers, body):
	if result == 2:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_HTTPREQ_CANT_CONNECT)
	if result == 3:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_HTTPREQ_CANT_RESOLVE)
	if result == 4:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_HTTPREQ_CONNECTION_ERR)
	if result == 6:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_HTTPREQ_NO_RESPONSE)
	if result == 9:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_HTTPREQ_CANT_OPEN)
	if result == 10:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_HTTPREQ_CANT_WRITE)
	if not result == 0:
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_DOWNLOADING_DATA)
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_MISSING_DATA_FILES)
		ErrorCodeServer.treat_error(ErrorCodeServer.ERROR_INITIALIZING_GAME)
