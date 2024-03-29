extends Node2D

const SPORE = preload("res://Spore.tscn")
var partners = []
# Called when the node enters the scene tree for the first time.
func _ready():
	generateSpores(2)
	for i in get_children():
		i.sporePrint()

func generateSpores(density):
	for i in range(0, density):
		var t = SPORE.instantiate()
		t.createFromDefaults()
		t.position = Vector2(round(randf()*300), round(randf()*300))
		add_child(t)
		#t.sporePrint()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addPartner(partner : Traits) -> void:
	partners.push_back(partner)
	if(len(partners) == 2):
		var s = SPORE.instantiate()
		s.position = Vector2(round(randf() * 300), round(randf() * 300))
		s.createFromTraits(partners[0].breed(partners[1]))
		s.mutate()
		for i in get_children():
			remove_child(i)
		add_child(s)
		s.position = Vector2(100, 100)
		partners[0].position = Vector2(400, 100)
		partners[1].position = Vector2(700, 100)
		for i in partners:
			add_child(i)
		partners = []
