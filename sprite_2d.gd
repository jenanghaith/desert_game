@tool




#func _on_area_2d_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.

class_name Platform
extends Node2D

const TILE_WIDTH: int = 128


## How many tiles wide is the platform?
@export_range(1, 20, 1, "suffix:tiles") var width: int = 3:
	set = _set_width

## Can you jump through the bottom of the platform?
@export var one_way: bool = false:
	set = _set_one_way

## Number of seconds after touching the platform for it to fall.
## Negative values won't fall.
@export var fall_time: float = -1

var fall_timer: Timer

@onready var _rigid_body := %RigidBody2D
@onready var _sprites := %Sprites
@onready var _collision_shape := %CollisionShape2D
@onready var _area_collision_shape := %AreaCollisionShape2D
@onready var _animation_player := %AnimationPlayer


func _set_width(new_width):
	width = new_width

	if is_node_ready():
		_recreate_sprites()


func _set_one_way(new_one_way):
	one_way = new_one_way

	if is_node_ready():
		_recreate_sprites()


func _recreate_sprites():
	for c in _sprites.get_children():
		c.queue_free()

	_collision_shape.one_way_collision = one_way
	_collision_shape.shape.set_size(Vector2(width * TILE_WIDTH, TILE_WIDTH))
	_area_collision_shape.shape.set_size(
		Vector2(width * TILE_WIDTH, _area_collision_shape.shape.size[1])
	)


func _ready():
	_recreate_sprites()

	fall_timer = Timer.new()
	fall_timer.one_shot = true
	fall_timer.timeout.connect(_fall)
	add_child(fall_timer)


func _on_area_2d_body_entered(body):
	if not body.is_in_group("players"):
		return
	if fall_time > 0:
		fall_timer.start(fall_time)
		_animation_player.play("shake")
	elif fall_time == 0:
		_rigid_body.call_deferred("set_freeze_enabled", false)


func _fall():
	_rigid_body.freeze = false
	_animation_player.stop()
