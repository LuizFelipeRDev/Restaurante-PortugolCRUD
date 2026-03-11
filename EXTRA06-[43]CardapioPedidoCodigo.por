programa
{
	inclua biblioteca Tipos
	inclua biblioteca Util
	
	funcao inicio()
	{
		cadeia userInput ="", pulaLinha = "\n\n"
		cadeia title2 = "===== - FAÇA SEU PEDIDO - ====="
		const inteiro qtdProd = 6
		cadeia arrayMenu[qtdProd][3] = {
				{"100","Cachorro Quente","1.20"},
				{"101","Bauro Simples","1.30"},
				{"102","Bauro Com Ovo","1.50"},
				{"103","Hamburguer","1.20"},
				{"104","Cheeseburguer","1.3"},
				{"105","Refrigerante","1.00"}
			}
		cadeia clientChoice[qtdProd][3]
			 //esse vetor é dividi em = [Qual Produto][Quantidade,Nome, Total]
		const inteiro TOTOPCAO = 4
		cadeia readOpcao [TOTOPCAO] = {"[1] - Ler Cardapio","[2] - Fazer Pedido ","[3] - Ver meu Pedido ", "[0] - Sair da Lanchonete"}
		
		faca{
			limpa()
			cadeia userChoice = ""
			para(inteiro m = 0; m < TOTOPCAO ; m++){
				escreva(readOpcao[m] + "\n")
			}
			escreva(">> ")
			leia(userInput)

			se(userInput == "1"){
				limpa()
				enquanto (userChoice != "0"){
					escreva("===== - MENU - =====",pulaLinha)
					para(inteiro i = 0; i < qtdProd;i++){
					escreva("Cod: " + arrayMenu[i][0] + "| Nome: " + arrayMenu[i][1] + "| Preço: " + arrayMenu[i][2]+"\n")
					}
					escreva("\nDigite [0] para voltar ao menu anterior: ")escreva("\n>> ")leia(userChoice)
					se(trataUserChoice(userChoice,"0")) pare
			
				}				
			}senao se(userInput == "2"){
				limpa()
				enquanto(userChoice != "0"){
					logico prodFound = falso
					escreva(title2,pulaLinha)
					escreva("Digite [0] para voltar ao menu anterior\n")
					escreva("[-] Digite o codigo do produto desejado\n")
					escreva(">> ")leia(userChoice)
					limpa()
					para(inteiro a = 0; a < qtdProd; a++){

						cadeia prodQuatd
						
						se(userChoice == arrayMenu[a][0]){

							prodFound = verdadeiro
							enquanto(verdadeiro){
								escreva(title2,pulaLinha)
								escreva("Produto: " + arrayMenu[a][1] + "\nPREÇO R$ "+ arrayMenu[a][2] + "\n\n")
								escreva("Quantas unidades desse produto você deseja? ")leia(prodQuatd)
								se(validaNumero(prodQuatd) == verdadeiro){

									logico newProduct = falso//protege os "se"

									para(inteiro b = 0;b < qtdProd ; b++){
										
										se(clientChoice[b][1] == arrayMenu[a][1]){
											inteiro currentQtd = converteCadInt(prodQuatd)
											inteiro newQtd = converteCadInt(prodQuatd)
												
											inteiro totalTemp = currentQtd + newQtd
											real price = converteCadReal(arrayMenu[a][2])
											real totalPrice = totalTemp * price

											clientChoice[b][0] = converteIntCad(totalTemp)
											clientChoice[b][2] = converteRealCad(totalPrice)
												
											escreva("Produto ",arrayMenu[a][1]," | Quantidade: ", prodQuatd , " | Valor Total R$ ",totalPrice)
											escreva("\n\nSalvando seu pedido")
											Util.aguarde(2000)
											newProduct = verdadeiro
											userChoice = "0"
											pare
											
										}
										
									}
									se(newProduct == falso){
										para(inteiro b = 0; b < qtdProd;b++){

										//se(clientChoice[b][1] != arrayMenu[a][1]) << ocasiona erro fazendo pedido ser rescrito, troquei == ""
											se(clientChoice[b][1] == ""){
												real currentQtd = converteCadReal(prodQuatd)
												real price = converteCadReal(arrayMenu[a][2])
											
												real totalPrice = currentQtd * price
												clientChoice[b][0] = prodQuatd
												clientChoice[b][1] = arrayMenu[a][1]
												clientChoice[b][2] = converteRealCad(totalPrice)
												escreva("Produto ",arrayMenu[a][1]," | Quantidade: ", prodQuatd , " | Valor Total R$ ",totalPrice)
												escreva("\n\nSalvando seu pedido")
												Util.aguarde(2000)
												newProduct = verdadeiro
												userChoice = "0"
												pare
											}
											
										}
											
									}
										
									
								}senao{
									erroMensagem("UNIDADE INVALIDA","Digite números inteiros para quantidade de produtos.")
								}
								pare
							}
						
						}
					}se(trataUserChoice(userChoice,"0")) pare			
					se(prodFound == falso){
						erroMensagem("CODIGO INVALIDO","Produto nao encontrado no cardapio")
					}
				}
				
						
			}senao se(userInput == "3"){
				limpa()
				//Devido aos espaços vazios usamos uma conferencia de logica
				enquanto(userChoice != "0"){
					logico clientRequest = falso
					escreva("===== - MEUS PEDIDOS - =====",pulaLinha)	
					para(inteiro c= 0;c < qtdProd; c++){
						
						real totalProdPrices = 0.0
						
						se(clientChoice[c][1] != ""){
							escreva("Quantidade: " , clientChoice[c][0] + "| ")
							escreva(clientChoice[c][1]+ "| ")
							escreva("Total R$ ",clientChoice[c][2])
							escreva("\n")

							totalProdPrices += converteCadReal(clientChoice[c][2])

							clientRequest = verdadeiro
						}
						escreva("\nValor Total dos Pedidos R$ ",totalProdPrices)										
					}
					se(clientRequest == falso){
						erroMensagem("SEM PEDIDO REALIZADO","Faça algum pedido antes de consultar seus pedidos")
					}
				escreva("\nDigite [0] para voltar ao menu anterior: ")escreva("\n>> ")leia(userChoice)
				}
			}
			//======================FINALMENU======================
			senao{
				erroMensagem("ENTRADA INVALIDA","Entre com uma opção igual ao do Menu")
			}
			
			limpa()
		
		}enquanto(userInput != "0")
	}




	funcao logico trataUserChoice(cadeia INPUT,cadeia OPCAO){
		logico validaOpcao = falso
		se(INPUT == OPCAO){
			validaOpcao = verdadeiro
		}senao{
			erroMensagem("ENTRADA INVALIDA","Entre com uma opção igual ao do Menu")
			validaOpcao = falso
		}retorne validaOpcao
	}

	funcao erroMensagem(cadeia title,cadeia desc){
		limpa()
		escreva("===== - ERRO DE " + title + " - =====\n\n")
		escreva(desc)
		Util.aguarde(1500)
		limpa()
	}

	funcao logico validaNumero(cadeia INPUT){
		logico isValid = falso
		se(Tipos.cadeia_e_inteiro(INPUT,10)){
			isValid = verdadeiro
		}senao{
			isValid = falso
		}retorne isValid
	}

	funcao inteiro converteCadInt(cadeia INPUT){
		 inteiro numero = Tipos.cadeia_para_inteiro(INPUT,10)
		 retorne numero
	}

	funcao cadeia converteIntCad(inteiro INPUT){
		 cadeia numeroString = Tipos.inteiro_para_cadeia(INPUT,10)
		 retorne numeroString
	}

	funcao real converteCadReal(cadeia INPUT){
		 real numeroReal = Tipos.cadeia_para_real(INPUT)
		 retorne numeroReal
	}	

	funcao cadeia converteRealCad(real INPUT){
		cadeia numeroString = Tipos.real_para_cadeia(INPUT)
		retorne numeroString
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4887; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */