class_name Traits
extends Node

@export var sporeStorage : float
@export var sporeMass : float
@export var nutrientNeed : float
@export var mutationRate : float
@export var mutationMultiplier : float
@export var critRate : float # ignores formula, no downside to upside
@export var bodySize : float
@export var bodyCount : float
@export var competitiveness : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createNew():
	sporeStorage = lerp(20, 40, randf())
	sporeMass = lerp(10, 15, randf())
	nutrientNeed = lerp(10, 15, randf())
	mutationRate = lerp(0.8, 1.2, randf())
	mutationMultiplier = lerp(0.5, 1.5, randf())
	critRate = lerp(5, 10, randf()) 
	bodySize = lerp(2, 3, randf())
	bodyCount = lerp(3, 25/bodySize, randf())
	competitiveness = lerp(0.5, 1.5, randf())

func createFromTraits(traits : Traits) -> void:
	sporeStorage = traits.sporeStorage
	sporeMass = traits.sporeMass
	nutrientNeed = traits.nutrientNeed
	mutationRate = traits.mutationRate
	critRate = traits.critRate
	bodySize = traits.bodySize
	bodyCount = traits.bodyCount
	competitiveness = traits.competitiveness

func calculateStep(largerBetter : bool = true) -> float:
	var value = 0
	if(randf() < mutationRate):
		value = (randf() - 0.5) * 2 * mutationMultiplier# -1 to 1
		if(value > 0.0 and not largerBetter and randf() < critRate):
			value *= -1
	return value

func mutate() -> void:
	# extra modifiers:
	sporeStorage += calculateStep(true)
	sporeMass += calculateStep(false)
	nutrientNeed += calculateStep(false)
	mutationRate += calculateStep(false)
	critRate += calculateStep(true)
	bodySize += calculateStep(true)
	bodyCount += calculateStep(true)
	competitiveness += calculateStep(true)
	
	# Phenotype:
	# body size
	if(randf() < mutationRate):
		var value = randf() / 5
		bodySize *= 0.9 + value
		nutrientNeed *= 0.9 + value # 0.9 : 1.1
	# body count
	if(randf() < mutationRate):
		var value = randf() / 5
		bodyCount *= 0.9 + value
		nutrientNeed *= 0.9 + value # 0.9 : 1.1
	if(randf() < mutationRate):
		var value = randf() / 5
		sporeMass *= 0.9 + value
		sporeStorage *= 0.9 + value

func breed(traits : Traits) -> Traits:
	var t = Traits.new()
	t.sporeStorage = lerp(sporeStorage, traits.sporeStorage, randf())
	t.sporeMass = lerp(sporeMass, traits.sporeMass, randf())
	t.nutrientNeed = lerp(nutrientNeed, traits.nutrientNeed, randf())
	t.mutationRate = lerp(mutationRate, traits.mutationRate, randf())
	t.critRate = lerp(critRate, traits.critRate, randf())
	t.bodySize = lerp(bodySize, traits.bodySize, randf())
	t.bodyCount = lerp(bodyCount, traits.bodyCount, randf())
	t.competitiveness = lerp(competitiveness, traits.competitiveness, randf())
	return t
