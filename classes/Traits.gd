class_name Traits
extends Node2D

var traits = {
	"sporeStorage" : 0,
	"sporeMass" : 0,
	"nutrientNeed" : 0,
	"mutationRate" : 0,
	"mutationMultiplier" : 0,
	"critRate" : 0, 
	"bodySize" : 0,
	"bodyCount" : 0,
	"competitiveness" : 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	updateList()

func sporePrint():
	print(self)
	var rounding = 10000
	print("Spore Storage:", round(traits.sporeStorage*rounding)/rounding, calculateObfuscation(traits.sporeStorage, 9), calculateObfuscation(traits.sporeStorage, 2), calculateObfuscation(traits.sporeStorage, 1))
	print("Spore Mass:", round(traits.sporeMass*rounding)/rounding)
	print("Nutrient Need:", round(traits.nutrientNeed*rounding)/rounding)
	print("Mutation Rate:", round(traits.mutationRate*rounding)/rounding)
	print("Mutation Multiplier:", round(traits.mutationMultiplier*rounding)/rounding)
	print("Crit Rate:", round(traits.critRate*rounding)/rounding)
	print("Body Size:", round(traits.bodySize*rounding)/rounding)
	print("Body Count:", round(traits.bodyCount*rounding)/rounding)
	print("Competitiveness", round(traits.competitiveness*rounding)/rounding)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateList():
	for c in $Control/VBoxContainer.get_children():
		$Control/VBoxContainer.remove_child(c)
		c.queue_free()
	var pos = 0
	for t in traits:
		var text = Label.new()
		text.text = " " + t + ": " +  str(round(traits[t]*100)/100)
		$Control/VBoxContainer.add_child(text)

func createFromDefaults():
	traits.sporeStorage = lerpf(20, 40, randf())
	traits.sporeMass = lerpf(10, 15, randf())
	traits.nutrientNeed = lerpf(10, 15, randf())
	traits.mutationRate = lerpf(0.5, 0.75, randf())
	traits.mutationMultiplier = lerpf(0.5, 1.5, randf())
	traits.critRate = lerpf(0.25, 0.35, randf()) 
	traits.bodySize = lerpf(2, 3, randf())
	traits.bodyCount = lerpf(3, 5/traits.bodySize, randf())
	traits.competitiveness = lerpf(0.5, 0.75, randf())
	updateList()

func createFromTraits(other : Traits) -> void:
	for t in other.traits:
		traits[t] = other.traits[t]
	updateList()

func calculateStep(largerBetter : bool = true) -> float:
	var value = 0
	if(randf() < traits.mutationRate):
		value = 0.9 + (randf() / 5)# * traits.mutationMultiplier# -1 to 1
		if(largerBetter):
			if(randf() < traits.critRate):
				value += randf() / 10
	
	return value

func mutate() -> void:
	# extra modifiers:
	traits.sporeStorage = max(20, traits.sporeStorage * calculateStep(true))
	traits.sporeMass = max(10, traits.sporeMass * calculateStep(false))
	traits.nutrientNeed = max(1, traits.nutrientNeed * calculateStep(false))
	traits.mutationRate = 1#max(1, traits.mutationRate + calculateStep(false))
	traits.critRate = max(0.25, traits.critRate * calculateStep(false))
	traits.bodySize = max(0.1, traits.bodySize * calculateStep(false))
	traits.bodyCount = max(1, traits.bodyCount * calculateStep(false))
	traits.competitiveness = max(0.5, traits.competitiveness * calculateStep(false))
	
	# Phenotype:
	# body size
	if(randf() < traits.mutationRate):
		var value = randf() / 5
		traits.bodySize *= 0.9 + value
		traits.nutrientNeed *= 0.9 + value # 0.9 : 1.1
	# body count
	if(randf() < traits.mutationRate):
		var value = randf() / 5
		traits.bodyCount *= 0.9 + value
		traits.nutrientNeed *= 0.9 + value # 0.9 : 1.1
	if(randf() <traits.mutationRate):
		var value = randf() / 5
		traits.sporeMass *= 0.9 + value
		traits.sporeStorage *= 0.9 + value

func calculateObfuscation(num, level):
	var h = float(str(num).hash())
	var deviation = num * level / 10
	var min = num - deviation
	var max = num + deviation
	return {"min": min, "max": max}
	

func breed(other : Traits) -> Traits:
	var t = Traits.new()
	for i in t.traits:
		t.traits[i] = lerpf(traits[i], other.traits[i], randf())
	return t

func onInfoDrawRequest():
	pass
	#$VBoxContainer.visible = true
	#$VBoxContainer.global_position = get_global_mouse_position() +  Vector2(20, 0)


func onMouseLeft():
	pass
	#$VBoxContainer.visible = false


func onInputEvent(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_parent().addPartner(self)
