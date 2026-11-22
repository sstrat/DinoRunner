extends Sprite2D


func _ready() -> void:
	var tween := create_tween().set_loops()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(
		self, "rotation_degrees", -360.0, 1.0
	).as_relative()
