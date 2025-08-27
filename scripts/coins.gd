extends Area2D



#func _ready() -> void:
	#print("iam a coin")
	#
#func _on_body_entered(body):
	#print("+1 coin")

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body):
	game_manager.add_point()
	animation_player.play("pickup_animation")
	
