extends Area3D

#loads in the dialogue
var resource = load("res://dialogue/main.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$CollisionShape3D.shape()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player3D":
		DialogueManager.show_dialogue_balloon(resource, "start")
		var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
		if Input.is_action_pressed("ui_accept"):
			dialogue_line = await DialogueManager.get_next_dialogue_line(resource)
