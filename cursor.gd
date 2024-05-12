extends Area2D

@onready var cursorImage = $cursorImage

var no_alcance = false
var atacando = false

func _process(_delta):
	mudar_cor()
	controle_de_ataque()
	global_position = get_cursor_position()

func get_cursor_position():
	return get_global_mouse_position()
	
func mouse_na_area(body):
	if body.is_in_group("alcance"):
		no_alcance = true

func mouse_fora_da_area(body):
	if body.is_in_group("alcance"):
		no_alcance = false

func mudar_cor():
	var vermelho:String = '960000'
	var branco:String = 'ffffff'
	
	if no_alcance == true:
		cursorImage.modulate = vermelho
	elif no_alcance == false:
		cursorImage.modulate = branco

#O COMBATE BASE DO JOGO CONSISTE EM SEGURAR O BOTAO ESQUERDO#
#E DESLIZAR O  MOUSE PELOS INIMIGOS, SIMULANDO UM CORTE DE ESPADA#

#QUANDO TODAS AS CONDICOES PARA FAZER A ACAO DO ATAQUE FOREM VERDADEIRAS#
#O CURSOR E COLOCADO EM UM GRUPO CHAMADO  "ATACANDO", E NO SCRIPT DO INIMIGO#
#TERA UMA FUNCAO QUE RECONHECERA QUANDO ESTIVER COLIDINDO COM O GRUPO DITO ANTERIORMENTE#
#E RECEBER O DANO#

func controle_de_ataque():
	if Input.is_action_pressed("lmb") and no_alcance:
		atacando = true
		add_to_group("ATACANDO")
	else:
		atacando = false
		remove_from_group("ATACANDO")



