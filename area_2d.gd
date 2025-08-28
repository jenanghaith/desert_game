extends Area2D

enum FlagPosition {
	DOWN,
	UP,
}

@export var sprite_frames: SpriteFrames
@export var flag_position: FlagPosition = FlagPosition.DOWN

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	_sprite.sprite_frames = sprite_frames
	_set_flag_position(flag_position)
	connect("body_entered", Callable(self, "_on_body_entered"))

func _set_flag_position(new_flag_position):
	flag_position = new_flag_position
	if flag_position == FlagPosition.DOWN:
		_sprite.play("down")
	else:
		_sprite.play("up")

func _on_body_entered(body):
	if body.is_in_group("player"):
		#_sprite.play("win")
		if flag_position == FlagPosition.DOWN:
			flag_position = FlagPosition.UP
			Global.raise_flag(self)
