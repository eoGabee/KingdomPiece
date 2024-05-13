extends Node

var experiencia:int = 0
var level:int = 0

var pausado = false

var objetivo = 500  #EXPERIENCIA NECESSARIA PARA PASSAR DE NIVEL#

func _process(_delta):
	if experiencia >= objetivo:
		pausado = true
		ganhar_level(1)
		objetivo = objetivo * 2
		experiencia = 0

#FUNCOES PUBLICAS PARA GERENCIAMENTO DE NIVEL#
func ganhar_xp(amount):
	experiencia += amount
func ganhar_level(amount):
	level += amount
