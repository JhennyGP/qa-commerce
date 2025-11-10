# language: pt

@web @checkout
Funcionalidade: Checkout
  Como visitante com itens no carrinho
  Deseja finalizar a compra
  Para receber a confirmacao do pedido

  Contexto:
    Dado que o usuario possui ao menos um produto no carrinho
    E acessa a pagina "Checkout"

  Esquema do Cenario: Finaliza a compra com apenas os campos obrigatorios
    Quando o usuario preenche os dados de entrega
      | campo        | valor              |
      | nome         | Jennifer           |
      | sobrenome    | Alepin             |
      | endereco     | Rua Exemplo        |
      | numero       | 100                |
      | cep          | 01001000           |
      | email        | jhenny@teste.com   |
    E o usuario seleciona o metodo de pagamento "<metodo>"
    E o usuario preenche dados de cartao quando aplicavel:
      | numero_cartao | <numero_cartao> |
      | validade      | <validade>      |
      | cvc           | <cvc>           |
    E marca a opcao "Li e concordo com os Termos e Condições deste site. *"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida a mensagem de sucesso "Obrigado pelo seu pedido"
    E o resumo do pedido deve apresentar ID do Pedido, Total, e Status corretos
    E deve ser exibida a mensagem de sucesso "Agradecemos a sua preferência!"
    Exemplos:
      | metodo             | numero_cartao       | validade | cvc |
      | Cartao de credito  | 4111111111111111    | 12/30    | 123 |
      | Pix                |                     |          |     |
      | Boleto             |                     |          |     |

  Esquema do Cenario: Finaliza a compra com todos os campos preenchidos
    Quando o usuario preenche os dados de entrega
      | campo        | valor              |
      | nome         | Jennifer           |
      | sobrenome    | Alepin             |
      | endereco     | Rua Exemplo        |
      | numero       | 100                |
      | cep          | 01001000           |
      | telefone     | 1100110011         |
      | email        | jhenny2@teste.com  |
    E o usuario seleciona o metodo de pagamento "<metodo>"
    E o usuario preenche dados de cartao quando aplicavel:
      | numero_cartao | <numero_cartao> |
      | validade      | <validade>      |
      | cvc           | <cvc>           |
    E marca a opcao "Li e concordo com os Termos e Condições deste site. *"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida a mensagem de sucesso "Obrigado pelo seu pedido"
    E o resumo do pedido deve apresentar ID do Pedido, Total, e Status corretos
    E deve ser exibida a mensagem de sucesso "Agradecemos a sua preferência!"
    Exemplos:
      | metodo             | numero_cartao       | validade | cvc |
      | Cartao de credito  | 4111111111111111    | 12/30    | 123 |
      | Pix                |                     |          |     |
      | Boleto             |                     |          |     |

  Esquema do Cenario: Impede finalizar quando campo obrigatorio de entrega esta vazio
    Quando o usuario preenche todos os campos de entrega, exceto "<campo_ausente>"
    E seleciona o metodo de pagamento "Pix"
    E marca a opcao "Li e concordo com os Termos e Condições deste site. *"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida mensagem de erro no campo "<campo_ausente>"
    E o pedido nao deve ser finalizado
    Exemplos:
      | campo_ausente |
      | nome          |
      | sobrenome     |
      | endereco      |
      | numero        |
      | cep           |
      | telefone      |
      | email         |

  Esquema do Cenario: Impede finalizar sem aceitar os termos
    Quando o usuario preenche corretamente todos os campos obrigatorios
    E seleciona o metodo de pagamento "<metodo>"
    E nao marca a opcao "Li e concordo com os Termos e Condições deste site. *"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida mensagem de erro informando que e necessario concordar com os termos
    E o pedido nao deve ser finalizado
    Exemplos:
      | metodo            |
      | Cartao de credito |
      | Pix               |
      | Boleto            |

  Esquema do Cenario: Campos de cartao sao obrigatorios quando metodo e cartao
    Quando o usuario preenche corretamente os campos de entrega
    E seleciona o metodo de pagamento "Cartao de credito"
    E deixa "<campo_cartao_faltando>" vazio
    E marca a opcao "Li e concordo com os Termos e Condições deste site. *"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida mensagem de erro "Este campo é obrigatório." no campo
    E o pedido nao deve ser finalizado
    Exemplos:
      | campo_cartao_faltando |
      | numero_cartao         |
      | validade              |
      | cvc                   |

  Esquema do Cenario: Valida formato dos campos de cartao
    Quando o usuario preenche corretamente os campos de entrega
    E seleciona o metodo de pagamento "Cartao de credito"
    E informa numero do cartao "<numero_cartao>"
    E informa validade "<validade>"
    E informa cvc "<cvc>"
    E marca a opcao "Li e concordo com os Termos e Condições deste site. *"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida mensagem de erro apropriada
    E o pedido nao deve ser finalizado
    Exemplos:
      | numero_cartao    | validade | cvc  |
      | 411111111111111  | 12/30    | 123  | 
      | 4111111111111111 | 00/25    | 123  | 
      | 4111111111111111 | 12/19    | 123  | 
      | 4111111111111111 | 12/30    | 12   |
      | 4111abc111111111 | 12/30    | 123  |
      | abc111111111     | 12       | 1    |

  Esquema do Cenario: Campos de cartao nao sao exigidos para Pix e Boleto
    Quando o usuario preenche corretamente os campos de entrega
    E seleciona o metodo de pagamento "<metodo>"
    Entao os campos de numero_cartao, validade e cvc nao devem ser validados como obrigatorios
    Exemplos:
      | metodo            |
      | Pix               |
      | Boleto            |

  Cenario: Mantem dados digitados apos erro
    Quando o usuario preenche todos os campos
    E erra o campo "email" com valor "jhenny_sem_arroba.com"
    E clica no botao "Finalizar Pedido"
    Entao deve ser exibida mensagem de erro no campo "email"
    E os demais campos devem permanecer preenchidos

# Bug encontrado - eh possivel ir para a pagina de checkout sem pedidos no carrinho.
  Cenario: Acesso ao checkout sem itens no carrinho
    Dado que o usuario nao possui itens no carrinho
    Quando o usuario acessa a pagina "Checkout" pelo link "/checkout.html"
    Entao o sistema deve voltar para a home

  Cenario: Ir para Minha Conta a partir do checkout sem login
    Quando o usuario clica em "Minha Conta" no topo
    Entao o sistema deve redirecionar para a pagina de login
    E o carrinho deve permanecer intacto ao retornar para o checkout
