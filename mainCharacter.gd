extends CharacterBody2D

#este enumerador e a base do uso de StateMachine nesse codigo#
#armazenando os possiveis estados do objeto dentro dele e logo#
#em seguida armazena o estado atual na variavel "estado", sendo#
#a referencia principal  desse sistema#

enum state  { #raiz dos estados#
	PARADO,
	ANDANDO
}
var estado = null #referencia principal(armazena o estado atual do objeto)#

@onready var textura_anim = $Textura/Anim
@onready var textura = $Textura

#status publicos do objeto#
@export var velocidade = 1000

#na funcao update abaixo o foco e chamar algumas funcoes#
#que usamos, e precisam ser atualizadas  a todo momento.#

func _process(_delta):
	if LevelControl.pausado == false:
		movimento()
		anim_control()
		move_and_slide()

#a movimentacao e bastante simples, captura o Input de direcao e#
#aplica a velocidade com um peso ao objeto, usando o metodo "lerp"#

func movimento():
	var direcao = Input.get_vector('esquerda', 'direita', 'cima', 'baixo').normalized()
	var aplicar_forca = direcao * velocidade
	var peso = 0.1
	
	var interpolacao = lerp(Vector2(), aplicar_forca, peso)

	if direcao:
		estado = state.ANDANDO
		velocity = interpolacao
	else:
		estado = state.PARADO
		velocity = Vector2()


func anim_control():
	match estado:
		state.PARADO:
			anim("Idle")
		state.ANDANDO:
			anim("Walk")
	flip()

func anim(Anim):
	textura_anim.play(Anim)

func flip():
	if velocity.x > 0:
		textura.flip_h = false
	elif velocity.x < 0:
		textura.flip_h = true

func _enter_tree():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pass
