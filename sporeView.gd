extends Node2D

const SPORE = preload("res://Spore.tscn")
var partners = []
# Called when the node enters the scene tree for the first time.
func _ready():
	generateSpores(2)
	var t = get_children()[0].breed(get_children()[1])
	t.sporePrint()

func generateSpores(density):
	for i in range(0, density):
		var t = SPORE.instantiate()
		t.createFromDefaults()
		t.position = Vector2(randf()*300, randf()*300)
		add_child(t)
		#t.sporePrint()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addPartner(partner : Traits) -> void:
	partners.push_back(partner)
	if(len(partners) == 2):
		var s = SPORE.instantiate()
		s.position = Vector2(randf() * 300, randf() * 300)
		s.createFromTraits(partners[0].breed(partners[1]))
		print("before mutate")
		s.sporePrint()
		print("after mutate:")
		s.mutate()
		s.sporePrint()
		for i in get_children():
			remove_child(i)
		add_child(s)
		for i in partners:
			add_child(i)
		partners = []