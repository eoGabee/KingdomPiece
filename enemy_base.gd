extends CharacterBody2D
class_name enemyBase

var velocidade = 1
var vida = 100

var player_ref:Node

@onready var animation = $Textura/Anim
@onready var texture = $Textura

#PARA OS INIMIGOS, ACHEI MELHOR FAZER UM SATEMACHINE#
#QUE DEPENDENDO DO ESTADO DO INIMIGO, ELE FAZ DIVERSAS ACOES#
#ENUM DOS ESTADOS ABAIXO:

enum StateMachine{
	ATACAR,
	PERSEGUIR,
	MORTO
}
var state  = StateMachine.PERSEGUIR
#A VARIAVEL "STATE" ARMAZENA O #

func _process(_delta):
	if LevelControl.pausado == false:
		player_ref = get_tree().get_first_node_in_group('Player')
		move_and_slide()
		movimento()
		morrer()

func movimento():
	if player_ref != null:
		var cauculo = player_ref.global_position - global_position
		var aplicar_forca = cauculo * velocidade
		
		flipar_sprite(cauculo)
		
		match state:
			StateMachine.ATACAR:
				velocity = Vector2()
				anim('Idle')
			StateMachine.PERSEGUIR:
				velocity = aplicar_forca
				anim('Walk')
			StateMachine.MORTO:
				LevelControl.ganhar_xp(PlayerStatus.recompensa)
				queue_free()
	else:
		print('erro')

func flipar_sprite(cauculo):
	if cauculo.x < 0:
		texture.flip_h = true
	elif cauculo.x > 0:
		texture.flip_h = false

func anim(Anim):
	#SEMPRE MANTER OS NOMES DAS ANIMACOES COMO 'Idle' ou 'Walk'#
	animation.play(Anim)
	
#CHECA SE O CURSOR ESTA EM MODO OFENSIVO E FAZ O INIMIGO LEVAR DANO#
func hit(area):
	if area.is_in_group("ATACANDO"):
		vida -= 50

func morrer():
	if vida <= 0:
		state = StateMachine.MORTO
