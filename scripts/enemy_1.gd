extends Node2D

var direction = 1 
const SPEED = 60
@onready var animated_sprite = $AnimatedSprite2D

@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castleft: RayCast2D = $RayCastleft

func _process(delta: float) -> void:
    
    animated_sprite.play("default")
    
    if ray_castright.is_colliding():
        direction = -1
        animated_sprite.flip_h= false 
    if ray_castleft.is_colliding():
        direction = 1
        animated_sprite.flip_h= true

        
    position.x += direction * SPEED * delta
