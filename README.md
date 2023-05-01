# README
 
# Sistema de Leilão 


Gerencie os itens de lotes de galpões com um sistema de leilão no qual possui dois usuários: 

Administradores: Que realizam o cadastro de produtos que estão disponíveis para venda, pela gestão do leilão incluindo a configuração de lotes, datas e lances mínimos e acompanhar os  pedidos recebidos para aprovação.

Usuários regulares: Podem criar uma conta na aplicação, buscar por produtos, ver detalhes de produtos e fazer um lance caso ainda seja possível.



## Requisitos necessários

Ruby 3.1.2 ou Superior

SQL Lite 1.4 ou Superior

Rails 7.0.4.3 ou Superior

## Executar o projeto:
Certifique de possuir instalado em sua máquina:

git
```terminal
  sudo apt install git
```
ruby > 3.1.2p20 :
```terminal
  sudo apt-get update
  sudo apt install ruby-full
  ruby -v 
```

rails > -v 7.0.4.3: 
``` terminal
 gem install rails   
 rails -v
```

Clone o repositório em sua máquina:
``` terminal
git clone https://github.com/MatheusOB21/stock-auction
```

Instale as dependências:
``` terminal
cd stock-auction
bundle install
```

Configure o Banco de Dados:
``` terminal
rails db:create
rails db:migrate
```

Execute aplicação: 
``` terminal
rails server
```

## Funcionalidades:
Usuários Administradores - Pendente

Cadastro de Itens para Leilão - Pendente

Configuração de Lotes - Pendente

Visualizar Lotes - Pendente

Fazendo Lances - Pendente

Validando Resultados - Pendente

Verificando Lotes Vencidos - Pendente

Dúvidas sobre um lote - Pendente

Bloqueio de CPFs - Pendente

Lotes Favoritos - Pendente

Busca de Produtos - Pendente