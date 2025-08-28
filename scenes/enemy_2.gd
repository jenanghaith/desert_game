extends Node2D

var direction = 1 
const SPEED = 60
@export var patrol_distance: float = 400
var start_x: float
@onready var animated_sprite = $AnimatedSprite2D

@onready var ray_castright: RayCast2D = $RayCastright
@onready var ray_castleft: RayCast2D = $RayCastleft
func _ready():
	start_x = global_position.x

func _process(delta: float) -> void:
	
	animated_sprite.play("default")
	position.x += direction * SPEED * delta
# Check if walked 30px away from start

	if ray_castright.is_colliding():
		direction = -1
		animated_sprite.flip_h= false 
	if ray_castleft.is_colliding():
		direction = 1
		animated_sprite.flip_h= true
	if abs(global_position.x - start_x) >= patrol_distance:
		flip()


func flip():
	direction *= -1
	scale.x =abs(scale.x) * direction
		
		
