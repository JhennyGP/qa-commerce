# language: pt

@web @home
Funcionalidade: Listagem de produtos na home
  Como visitante
  Deseja ver os produtos corretamente na home
  Para decidir o que comprar

  Contexto:
    Dado que o usuario acessa a pagina inicial da loja

  Esquema do Cenario: Card de produto mostra todas as informacoes
    Quando a home e carregada
    Entao o card do produto "<produto>" deve exibir imagem visivel
    E o card do produto "<produto>" deve exibir nome "<produto>"
    E o card do produto "<produto>" deve exibir preco em formato monetario valido
    E o card do produto "<produto>" deve exibir campo de quantidade com valor padrao "1"
    E o card do produto "<produto>" deve exibir o botao "Adicionar ao Carrinho"
    Exemplos:
      | produto                                                   |
      | Moletom com capuz "Se você acha que nada é impossível..." |
      | Moletom com capuz "Na minha máquina funciona"             |

  Esquema do Cenario: Navegacao da home para detalhes via nome e imagem
    Quando o usuario clica no nome do produto "<produto>" na home
    Entao o sistema deve abrir a pagina de detalhes do produto com URL contendo "product.html?id=<id>"
    E a pagina de detalhes deve exibir o produto "<produto>"
    Quando o usuario retorna para a home
    E clica na imagem do produto "<produto>"
    Entao o sistema deve abrir a mesma pagina de detalhes do produto com o mesmo "<id>"
    Exemplos:
      | produto                                                   | id |
      | Moletom com capuz "Se você acha que nada é impossível..." | 1  |
      | Moletom com capuz "Na minha máquina funciona"             | 2  |

  Esquema do Cenario: Consistencia de preco entre home e detalhes
    Quando a home e carregada
    E o usuario captura o preco do produto "<produto>" na home
    E o usuario navega para a pagina de detalhes do produto "<produto>"
    Entao o preco exibido na pagina de detalhes deve ser igual ao preco capturado na home
    Exemplos:
      | produto                                                   |
      | Moletom com capuz "Se você acha que nada é impossível..." |
      | Moletom com capuz "Na minha máquina funciona"             |

  # Fluxos alternativos defensivos (home)
  Cenario: Card de produto sem imagem exibe placeholder
    Dado que existe um produto com imagem indisponivel na home
    Quando a home e carregada
    Entao o card deve exibir uma imagem placeholder legivel
    E o layout nao deve quebrar

  Cenario: Card de produto sem preco exibe estado indisponivel
    Dado que existe um produto com preco indisponivel na home
    Quando a home e carregada
    Entao o card deve exibir texto "Indisponivel"
    E o botao "Adicionar ao Carrinho" deve estar desabilitado