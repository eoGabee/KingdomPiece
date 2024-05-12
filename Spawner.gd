extends Node2D

@onready var timer = $Timer
@onready var enemy_peao  = preload("res://Objetos/bases/enemy_base.tscn")
@onready var spawn_range = Vector2(48,48)  ##Tamanho do cenario

@export var inimigos_porsec = 1
var contador_inimigos = 0
var limite_inimigos = 5

func _on_timer_timeout():
	spawn(enemy_peao)

func randomizar_timer():
	var randi = randi_range(1, 2)
	timer.wait_time = randi

func spawn(instance_):
	if LevelControl.pausado == false:
		randomizar_timer()
		if contador_inimigos <= limite_inimigos:
			for i in inimigos_porsec:
				var instance = instance_.instantiate()
				var position_x = randi_range(0, spawn_range.x)
				var position_y = randi_range(0, spawn_range.y)
				instance.global_position = Vector2()
				get_node(".").add_child(instance)
