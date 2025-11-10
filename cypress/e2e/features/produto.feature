# language: pt

@web @produto
Funcionalidade: Pagina de detalhes do produto
  Como visitante
  Deseja ver detalhes completos e consistentes do produto
  Para concluir a compra com confianca

  Esquema do Cenario: Detalhes do produto sao exibidos
    Dado que o usuario acessa a URL "product.html?id=<id>"
    Entao a pagina deve exibir o nome "<produto>"
    E a pagina deve exibir imagem principal visivel
    E a pagina deve exibir preco em formato monetario valido
    E a pagina deve exibir campo de quantidade com valor padrao "1"
    E a pagina deve exibir o botao "Adicionar ao carrinho"
    E a pagina deve exibir o botao "Voltar para Home"
    E o titulo da aba deve conter "<produto>"
    Exemplos:
      | id | produto                                                    |
      | 1  | Moletom com capuz "Se você acha que nada é impossível..."  |
      | 2  | Moletom com capuz "Na minha máquina funciona"              |

  Esquema do Cenario: Adicionar ao carrinho a partir da pagina de detalhes
    Dado que o usuario esta na pagina de detalhes do produto "<produto>" com id "<id>"
    Quando o usuario informa a quantidade "<qtd>"
    E clica no botao "Adicionar ao carrinho"
    Entao o icone do carrinho deve exibir "<badge_esperado>" item
    E o carrinho deve listar o produto "<produto>" com quantidade "<qtd>"
    Exemplos:
      | id | produto                                                    | qtd | badge_esperado |
      | 1  | Moletom com capuz "Se você acha que nada é impossível..."  | 1   | 1              |
      | 2  | Moletom com capuz "Na minha máquina funciona"              | 3   | 3              |

  Cenario: Botao Voltar para Home retorna para a listagem
    Dado que o usuario esta na pagina de detalhes de qualquer produto
    Quando o usuario clica em "Voltar para Home"
    Entao o sistema deve redirecionar para a pagina inicial da loja
    E a lista de produtos deve ser exibida

  Esquema do Cenario: Consistencia entre nome e id no carregamento
    Dado que o usuario acessa a URL "product.html?id=<id>"
    Entao o nome do produto exibido deve corresponder ao id "<id>" de "<produto>"
    Exemplos:
      | id | produto                                                    |
      | 1  | Moletom com capuz "Se você acha que nada é impossível..."  |
      | 2  | Moletom com capuz "Na minha máquina funciona"              |

  Cenario: Persistencia de carrinho ao navegar entre detalhes e home
    Dado que o usuario adicionou um produto a partir da pagina de detalhes
    Quando o usuario retorna para a home
    Entao o icone do carrinho deve manter a mesma quantidade exibida anteriormente

  Cenario: Imagem do produto contem atributo alt descritivo
    Dado que o usuario esta na pagina de detalhes do produto
    Entao a imagem principal deve conter atributo alt nao vazio

  Cenario: Acesso com id inexistente redireciona com mensagem
    Dado que o usuario acessa a URL "product.html?id=9999"
    Entao o sistema deve redirecionar para a home ou pagina de erro
    E deve exibir mensagem informando que o produto nao foi encontrado

  Esquema do Cenario: Acesso com id invalido e tratado
    Dado que o usuario acessa a URL "product.html?id=<id_invalido>"
    Entao o sistema deve impedir o carregamento do produto
    E deve redirecionar para a home ou exibir mensagem de parametro invalido
    Exemplos:
      | id_invalido |
      | abc         |
      | -1          |
      |             |

  Esquema do Cenario: Quantidade invalida e bloqueada
    Dado que o usuario esta na pagina de detalhes do produto "<produto>" com id "<id>"
    Quando o usuario informa a quantidade "<qtd_invalida>"
    E tenta clicar no botao "Adicionar ao carrinho"
    Entao o sistema deve impedir a adicao e exibir mensagem de quantidade invalida
    E o icone do carrinho deve permanecer inalterado
    Exemplos:
      | id | produto                                                    | qtd_invalida |
      | 1  | Moletom com capuz "Se você acha que nada é impossível..."  | 0            |
      | 1  | Moletom com capuz "Se você acha que nada é impossível..."  | -2           |
      | 2  | Moletom com capuz "Na minha máquina funciona"              | abc          |
      | 2  | Moletom com capuz "Na minha máquina funciona"              | 99999999999  |

  Cenario: Preco indisponivel bloqueia adicao
    Dado que o usuario esta em um produto cujo preco nao esta disponivel
    Quando o usuario tenta adicionar ao carrinho
    Entao o sistema deve desabilitar o botao de adicao e exibir mensagem de indisponibilidade
