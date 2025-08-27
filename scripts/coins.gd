extends Area2D



#func _ready() -> void:
    #print("iam a coin")
    #
#func _on_body_entered(body):
    #print("+1 coin")


func _on_body_entered(body):
    print("+1 coin")
    queue_free()
