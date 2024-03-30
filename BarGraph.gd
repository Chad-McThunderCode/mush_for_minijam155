class_name BarGraph
extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#100 (value range), some min, some max, element width in pixel, some value in-between
func buildFromValues(total, min, max, width, actual):
	var c = Color.WHITE
	c.a = 0.7
	modulate = c
	print("total", total, "min", min, "max", max, "width", width)
	var white=StyleBoxFlat.new()
	white.bg_color = Color.CADET_BLUE
	
	var valueWidth = width/total
	
	var blue=StyleBoxFlat.new()
	blue.bg_color = Color.CORNFLOWER_BLUE
	
	var l = Label.new()
	l.text = str(min)
	var lw = valueWidth * min + 30
	l.custom_minimum_size.x = lw
	l.add_theme_stylebox_override("normal", white)
	
	var m = Label.new()
	#m.text = str(actual)
	var mw = valueWidth * max - valueWidth * min
	m.custom_minimum_size.x = mw
	m.add_theme_stylebox_override("normal", blue)
	
	var r = Label.new()
	r.add_theme_stylebox_override("normal", white)
	r.text = str(max)
	r.custom_minimum_size.x = valueWidth * total - valueWidth * max + 30
	add_child(l)
	add_child(m)
	add_child(r)
	print(get_children())
