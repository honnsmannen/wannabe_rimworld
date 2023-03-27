extends VisibilityNotifier2D




func _ready() -> void:
	$VisibilityNotifier2D.connect("screen_entered", self, "show")
	$VisibilityNotifier2D.connect("screen_exited", self, "hide")
