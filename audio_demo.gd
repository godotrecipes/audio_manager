extends MarginContainer

# Choose a folder of audio files
@export_dir var sound_dir

func _ready():
	# Load all sounds in the chosen folder
	var dir = DirAccess.open(sound_dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() in ["wav", "ogg"]:
				add_button(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
		

func add_button(file_name):
	# Add a button that plays an assigned audio file
	var b = Button.new()
	$CenterContainer/GridContainer.add_child(b)
	b.add_theme_font_override("font", load("res://assets/Poppins-Medium.ttf"))
	b.text = file_name
	b.pressed.connect(on_audio_button_pressed.bind(b))
	
	
func on_audio_button_pressed(button):
	# Play the button's assigned sound
	var path = sound_dir + "/" + button.text
	AudioManager.play(path)
	

func _process(delta):
	# Update the audio manager's stats
	$CanvasLayer/HBoxContainer/Label2.text = str(AudioManager.available.size())
	$CanvasLayer/HBoxContainer/Label3.text = str(AudioManager.queue.size())
