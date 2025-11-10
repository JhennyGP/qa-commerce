# language: pt

@web @carrinho
Funcionalidade: Adicionar produto ao carrinho
  Como visitante da loja
  Deseja adicionar produtos ao carrinho
  Para prosseguir ao checkout com os valores corretos

  Contexto:
    Dado que o usuario acessa a pagina inicial da loja
    E visualiza a lista de produtos disponiveis

  Esquema do Cenario: Adicao simples de 1 unidade a partir da home
    Quando o usuario seleciona o produto "<produto>"
    E informa a quantidade "<qtd>"
    E clica no botao "Adicionar ao Carrinho"
    Entao o icone do carrinho deve exibir "<qtd>" item
    E o carrinho deve listar o produto "<produto>" com quantidade "<qtd>"
    E o subtotal do carrinho deve ser igual ao preco "<preco>" unitario do produto
    Exemplos:
      | produto                                                   | qtd  | preco    |
      | Moletom com capuz "Se você acha que nada é impossível..." | 1    | 59.00    |
      | Moletom com capuz "Na minha máquina funciona"             | 1    | 59.00    |

  Esquema do Cenario: Adicao de multiplas unidades
    Quando o usuario seleciona o produto "<produto>"
    E informa a quantidade "<qtd>"
    E clica no botao "Adicionar ao Carrinho"
    Entao o icone do carrinho deve exibir "<qtd>" item
    E o carrinho deve listar o produto "<produto>" com quantidade "<qtd>"
    E o subtotal do carrinho deve ser igual ao preco "<preco>" unitario multiplicado por "<qtd>"
    Exemplos:
      | produto                                                   | qtd | preco    |
      | Moletom com capuz "Se você acha que nada é impossível..." | 2   | 59.00    |
      | Moletom com capuz "Na minha máquina funciona"             | 3   | 59.00    |

  Cenario: Adicao de produtos diferentes somando itens no badge
    Quando o usuario seleciona o primeiro produto
    E informa a quantidade "1"
    E clica no botao "Adicionar ao Carrinho"
    E o usuario seleciona o segundo produto
    E informa a quantidade "1"
    E clica no botao "Adicionar ao Carrinho"
    Entao o icone do carrinho deve exibir "2" item
    E o carrinho deve listar os dois produtos com quantidade "1" cada
    E o subtotal do carrinho deve refletir a soma dos dois precos unitarios

  Esquema do Cenario: Atualizacao de quantidade dentro do carrinho
    Dado que o usuario adicionou o produto "<produto>" com quantidade "1" ao carrinho
    Quando o usuario acessa a pagina "Carrinho"
    E altera a quantidade do produto "<produto>" para "<qtd_nova>"
    Entao o carrinho deve atualizar o subtotal do item para quantidade "<qtd_nova>"
    E o total geral deve refletir a nova quantidade e o frete exibido
    Exemplos:
      | produto                                                   | qtd_nova |
      | Moletom com capuz "Se você acha que nada é impossível..." | 2        |

  Cenario: Remocao de item do carrinho
    Dado que o usuario adicionou um produto ao carrinho
    Quando o usuario acessa a pagina "Carrinho"
    E clica no botao "Remover" do produto
    Entao o produto deve desaparecer da lista do carrinho
    E o icone do carrinho deve exibir "0" item
    E o total geral deve ser zerado ou nao exibido

  Esquema do Cenario: Bloqueio de quantidade invalida na adicao
    Quando o usuario seleciona o produto "<produto>"
    E informa a quantidade "<qtd_invalida>"
    E tenta clicar no botao "Adicionar ao Carrinho"
    Entao o sistema deve impedir a adicao do produto
    E deve exibir mensagem informando que a quantidade informada e invalida
    E o icone do carrinho deve permanecer inalterado
    E nao deve constar os produtos no carrinho
    Exemplos:
      | produto                                       | qtd_invalida |
      | Moletom com capuz "Na minha máquina funciona" | 0            |
      | Moletom com capuz "Na minha máquina funciona" | -1           |
      | Moletom com capuz "Na minha máquina funciona" | abc          |
