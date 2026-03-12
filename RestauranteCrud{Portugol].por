programa
{
	inclua biblioteca Tipos
	inclua biblioteca Util
	inclua biblioteca Matematica --> Mat
	inclua biblioteca Texto
	
	const inteiro TOTALOPCAO = 5
	const inteiro QTDPROD = 6
	
	funcao inicio()
	{
		cadeia entradaUsuario ="", pulaLinha = "\n\n"
		cadeia title2 = "===== - FAÇA SEU PEDIDO - ====="
		cadeia vetorMenu[QTDPROD][3] = {
				{"100","Cachorro Quente","1.20"},
				{"101","Bauro Simples","1.30"},
				{"102","Bauro Com Ovo","1.50"},
				{"103","Hamburguer","1.20"},
				{"104","Cheeseburguer","1.35"},
				{"105","Refrigerante","1.00"}
			}
		cadeia clientComanda[QTDPROD][4] = {
			   {"3","Cachorro Quente","3.60","100"},
			   {"","","",""},
			   {"","","",""},
			   {"","","",""},
			   {"","","",""},
			   {"","","",""}
			}

		cadeia readOpcao [TOTALOPCAO] = {"[1] - Ler Cardapio","[2] - Fazer Pedido ","[3] - Ver meu Pedido ","[4] - Remover Pedido ","[0] - Sair da Lanchonete"}
		
		faca{
			limpa()
			cadeia escolhaUsuario = ""

			escreva("==== - RESTAURANTE DO CRUD - ====",pulaLinha)
			para(inteiro m = 0; m < TOTALOPCAO ; m++){
				escreva(readOpcao[m] + "\n")
			}
			escreva(">> ")
			leia(entradaUsuario)

			se(entradaUsuario == "1"){
				limpa()
				enquanto (escolhaUsuario != "0"){
					escreva("===== - MENU - =====",pulaLinha)
					para(inteiro i = 0; i < QTDPROD;i++){
						escreva("Cod: " + vetorMenu[i][0] + " | Nome: " + vetorMenu[i][1] + " | Preço: " + vetorMenu[i][2]+"\n")
						Util.aguarde(100)
					}
					escreva("\nDigite [0] para voltar ao menu anterior: ")escreva("\n>> ")
					leia(escolhaUsuario)
					se(trataescolhaUsuario(escolhaUsuario,"0")) pare
			
				}				
			}senao se(entradaUsuario == "2"){
				limpa()
				enquanto(escolhaUsuario != "0"){
					logico achouProduto = falso
					
					escreva(title2,pulaLinha)
					escreva("Digite [0] para voltar ao menu anterior\n")
					escreva("[-] Digite o codigo do produto desejado\n")
					escreva(">> ")
					leia(escolhaUsuario)
					limpa()
					para(inteiro a = 0; a < QTDPROD; a++){

						cadeia prodQuatd
						
						se(escolhaUsuario == vetorMenu[a][0]){

							achouProduto = verdadeiro
							logico pedidoFinalizado = falso
							
							enquanto(nao pedidoFinalizado){
								
								escreva(title2,pulaLinha)
								escreva("Produto: " + vetorMenu[a][1] + "\nPREÇO R$ "+ vetorMenu[a][2] + "\n\n")
								escreva("Quantas unidades desse produto você deseja? ")
								leia(prodQuatd)
								
								se(validaNumero(prodQuatd)){

									logico novoProduto = falso
									

									para(inteiro b = 0;b < QTDPROD ; b++){
										
										se(clientComanda[b][1] == vetorMenu[a][1]){
											inteiro currentQtd = converteCadInt(clientComanda[b][0])
											inteiro newQtd = converteCadInt(prodQuatd)
												
											inteiro totalTemp = currentQtd + newQtd
											real price = converteCadReal(vetorMenu[a][2])
											real totalPrice = arredonda(totalTemp * price)

											clientComanda[b][0] = converteIntCad(totalTemp)
											clientComanda[b][2] = converteRealCad(totalPrice)
											clientComanda[b][3] = vetorMenu[a][0]
												
											escreva("Produto ",vetorMenu[a][1]," | Quantidade: ", prodQuatd , " | Valor Total R$ ",newQtd*price)
											escreva("\n\nSalvando seu pedido")
											Util.aguarde(2000)
											
											novoProduto = verdadeiro
											pedidoFinalizado = verdadeiro
											escolhaUsuario = "0"
											pare										
										}										
									}
									se(nao novoProduto ){
										para(inteiro b = 0; b < QTDPROD;b++){

											se(clientComanda[b][1] == ""){
												real currentQtd = converteCadReal(prodQuatd)
												real price = converteCadReal(vetorMenu[a][2])
											
												real totalPrice = arredonda(currentQtd * price)
												clientComanda[b][0] = prodQuatd
												clientComanda[b][1] = vetorMenu[a][1]
												clientComanda[b][2] = converteRealCad(totalPrice)
												clientComanda[b][3] = vetorMenu[a][0]
												
												escreva("Produto ",vetorMenu[a][1]," | Quantidade: ", prodQuatd , " | Valor Total R$ ",totalPrice)
												escreva("\n\nSalvando seu pedido")
												Util.aguarde(2000)
												
												novoProduto = verdadeiro
												pedidoFinalizado = verdadeiro
												escolhaUsuario = "0"
												pare

											}											
										}
									}
								}senao{
									erroMensagem("UNIDADE INVALIDA","Digite números inteiros para quantidade de produtos.")
								}							
							}
						}
					}se(trataescolhaUsuario(escolhaUsuario,"0")) pare			
				}		
			}senao se(entradaUsuario == "3"){
				limpa()
				enquanto(escolhaUsuario != "0"){
					logico clientRequest = falso
					real totalProdPrices = 0.0
					escreva("===== - MEUS PEDIDOS - =====",pulaLinha)	
					para(inteiro c= 0;c < QTDPROD; c++){
						
						se(clientComanda[c][1] != ""){
							escreva("Quantidade: " , clientComanda[c][0] + " | ")
							escreva(clientComanda[c][1]+ " | ")
							escreva("Total R$ ",clientComanda[c][2])
							escreva("\n")

							Util.aguarde(100)

							totalProdPrices += converteCadReal(clientComanda[c][2])

							clientRequest = verdadeiro
						}
														
					}
					se(clientRequest == falso){
						erroMensagem("SEM PEDIDO REALIZADO","Faça algum pedido antes de consultar seus pedidos")
					}
				escreva("\nValor Total dos Pedidos R$ ",totalProdPrices)		
				escreva("\nDigite [0] para voltar ao menu anterior: ")escreva("\n>> ")
				leia(escolhaUsuario)
				}
			}senao se(entradaUsuario == "4"){
				limpa()
				enquanto(escolhaUsuario != "0"){
			
					logico removerPedido = falso
					cadeia escolhaUsuario04
					cadeia title4 = "===== - REMOVER PEDIDO - ====="
					
					escreva(title4,pulaLinha)		
					///================= VISUAL =======================///
					
					para(inteiro i = 0; i < QTDPROD; i++){
							
						se(clientComanda[i][1] != ""){ 
								
							escreva(clientComanda[i][3] + " | ")
							escreva("Quantidade: " , clientComanda[i][0] + " | ")
							escreva(clientComanda[i][1]+ " | ")
							escreva("Total R$ ",clientComanda[i][2])
							escreva("\n")
							Util.aguarde(100)
						}		
					}
					
					///========================================///
					
					escreva("\nDigite o codigo do produto que você quer remover")
					escreva("\nDigite [0] para voltar ao menu anterior: ")
					escreva("\n>> ")
					leia(escolhaUsuario)
					limpa()

					para(inteiro i = 0; i < QTDPROD; i++){

						se(escolhaUsuario == clientComanda[i][3]){

							enquanto(nao removerPedido){

								inteiro tempQtd = converteCadInt(clientComanda[i][0])
								
								escreva(title4,pulaLinha)
								escreva("[0] Digite zero voltar ao menu do restaurante\n")
								escreva("[S] Digite S para remover tudo\n")
								escreva("[-] Digite a quantidade a remover\n")	
								escreva(">> ")
								leia(escolhaUsuario04)
								limpa()
			
								se(Texto.caixa_alta(escolhaUsuario04) == "S"){
									se(clientComanda[i][3] == escolhaUsuario){
									clientComanda[i][0] = ""
									clientComanda[i][1] = ""
									clientComanda[i][2] = ""
									clientComanda[i][3] = ""
									escolhaUsuario = "0"
	
									removerPedido = verdadeiro
									}		
									
								}senao se(escolhaUsuario04 == "0"){
									removerPedido = verdadeiro
									escolhaUsuario = "0"		
													}
								senao se(validaNumero(escolhaUsuario04)){
									
									inteiro tempEscolhaQtd = converteCadInt(escolhaUsuario04)

									se(tempEscolhaQtd > 0 e tempEscolhaQtd <= tempQtd){

										inteiro calcTotal = tempQtd - tempEscolhaQtd
										real valorTotTemp = converteCadReal(clientComanda[i][2])
										inteiro quantidadeTemp = converteCadInt(clientComanda[i][0])
				
										clientComanda[i][2] = converteRealCad((valorTotTemp/quantidadeTemp) * (quantidadeTemp - tempEscolhaQtd))
										clientComanda[i][0] = converteIntCad(calcTotal)
										
										se(calcTotal == 0){
											clientComanda[i][0] = ""
											clientComanda[i][1] = ""
											clientComanda[i][2] = ""
											clientComanda[i][3] = ""
										}										
										
										escreva("Removendo Seu Pedido da Comanda")
										Util.aguarde(2000)
										removerPedido = verdadeiro
										escolhaUsuario = "0"	
										
									}senao{
										erroMensagem("QUANTIDADE INVALIDA","A quantidade de ser maior que zero e igual ou \nmenor que a quantidade do pedido registrado na comanda")
									}
								}senao{
									erroMensagem("ENTRADA INVALIDA","Entre Com Uma Opçâo Igual A Do Menu")
								}					
							}			
						}				
					
					}
					se(trataescolhaUsuario(escolhaUsuario,"0")) pare						
				}	
			
			//======================FINALMENU======================
			}senao se(entradaUsuario == "0"){
				limpa()
				escreva("==== - SAINDO DO PROGRAMA - ====")
				Util.aguarde(1000)
			}
			senao  {
				erroMensagem("ENTRADA INVALIDA","Entre com uma opção válida ao do Menu")
			}
			
			limpa()
		
		}enquanto(entradaUsuario != "0")
		escreva("\n==== - FIM DO PROGRAMA - ====\n")
	}


	funcao logico trataescolhaUsuario(cadeia INPUT,cadeia OPCAO){
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

	funcao real arredonda(real INPUT){
		real saida = Mat.arredondar(INPUT, 2)
		retorne saida
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
 * @POSICAO-CURSOR = 9106; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */