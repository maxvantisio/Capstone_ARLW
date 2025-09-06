extends CanvasLayer
#@onready var dialogue_manager = get_node("res://addons/dialogue_manager")
var resource = load("res://dialogue/main.dialogue")
#@export var start_title: String = "start"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# can also do:: var dialogue_line = await resource.get_next_dialogue_line("start")
	
	#if dialogue_resource:
		#DialogueManager.show_dialogue_balloon(DialogueResource, start_title)

func _input(event):
	# had to change from Input. to event. due to smth about global input states
	if event.is_action_pressed("ui_left"):
		DialogueManager.show_dialogue_balloon(resource, "start")
		#dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	
	if event.is_action_pressed("ui_accept"):
		handle_curr_line()

var current_line: DialogueLine = null

func handle_curr_line() -> void:
	if current_line == null:
		#start dialogue
		current_line = await DialogueManager.get_next_dialogue_line(resource,"start")
	else:
		#continue dialogue
		current_line = await DialogueManager.get_next_dialogue_line(resource)
	if current_line == null:
		print("No more dialogue")
		return
	
	print("Speaker:",current_line.character)
	print("Text:",current_line.text)
	print("Tags:",current_line.tags)
	print("Color tag:",current_line.get_tag_value("color"))
	
	var color_tag = current_line.get_tag_value("color")
	if color_tag == "red":
		$TextureRect.texture = load("res://sprites/tempRed.png")
	elif color_tag == "blue":
		$TextureRect.texture = load("res://sprites/tempBlue.png")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
