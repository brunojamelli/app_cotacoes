# App de Cotações e Bolsas
Um aplicativo Flutter que exibe cotações de moedas e dados das bolsas de valores em tempo real, utilizando a API do HG Brasil.

## Funcionalidades

- Exibe a cotação do dólar em um card destacado.
- Mostra uma lista horizontal com outras moedas (Euro, Libra, Iene, etc.).
- Exibe uma lista de bolsas de valores (IBOVESPA, NASDAQ, DOWJONES, etc.).
- Atualiza os dados ao clicar no botão de refresh.
- Destaque visual para variações positivas (verde) e negativas (vermelho).

## Estrutura do Projeto

Aqui está a organização dos arquivos do projeto:

```markdown
lib/
├── main.dart
├── models/
│   ├── cotacao.dart
│   └── bolsa.dart
├── services/
│   └── api_service.dart
├── utils/
│   └── variacao_utils.dart
├── widgets/
│   ├── bolsa_card.dart
│   ├── cotacao_card.dart
│   ├── dolar_card.dart
│   ├── moedas_section.dart
│   ├── bolsas_section.dart
│   ├── loading_widget.dart
│   └── custom_error_widget.dart
└── screens/
    └── home_screen.dart
```

### Descrição dos Arquivos
-  **main.dart**: Ponto de entrada do aplicativo.
- **models/**: Contém as classes de modelo para cotações e bolsas.
- **services/**: Contém a lógica de requisição à API.
- **utils/**: Funções utilitárias para cálculos e formatações.
- **widgets/**: Widgets reutilizáveis para a interface do usuário.
- **screens/**: Contém as telas do aplicativo.

## Como Executar o Projeto
```bash 
git clone https://github.com/brunojamelli/app_cotacoes.git
```

```bash
cd app_cotacoes
```

```bash
flutter pub get
```

```bash
flutter run
```

## Dependências
O projeto utiliza as seguintes dependências:

- **http**: Para fazer requisições à API.
- **flutter/material.dart**: Para a interface do usuário.