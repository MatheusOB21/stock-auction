# README
 
Sistema de Leilão
Gerencie os itens de lotes de galpões com um sistema de leilão no qual possui dois usuários: 
Administradores: Que realizam o cadastro de produtos que estão disponíveis para venda, pela gestão do leilão incluindo a configuração de lotes, datas e lances mínimos e acompanhar os  pedidos recebidos para aprovação.
Usuários regulares: Podem dar criar uma conta na aplicação, buscar por produtos, ver detalhes de produtos e fazer um lance caso ainda seja possível.

Requisitos Necessários:
Ruby 3.1.2 ou Superior
SQL Lite 1.4 ou Superior
Rails 7.0.4.3 ou Superior

Funcionalidades:
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

Para executar o projeto:

Certifique de possuir instalado em sua máquina:

git
  sudo apt install git
ruby:
  sudo apt-get update
  sudo apt install ruby-full
  ruby -v -> ruby 3.1.2p20

rails: 
  gem install rails -v 7.0.4.3
  rails -v

Clone o repositório em sua máquina:

git clone https://github.com/MatheusOB21/stock-auction

Instale as dependências:

cd stock-auction
bundle install

Configure o Banco de Dados:

rails db:create
rails db:migrate

Execute aplicação: 

rails server