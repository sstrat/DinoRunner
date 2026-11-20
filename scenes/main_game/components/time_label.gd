extends Label
class_name GameTimer


var _time_elapsed: float = 0


func _process(delta):
	self.text = "%.1f" % _time_elapsed
	tick_up_time(delta)


func get_time():
	return _time_elapsed


func tick_up_time(amount: float):
	_time_elapsed += amount
