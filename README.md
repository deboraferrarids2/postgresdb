# postgresdb
banco de dados gerenciavel
postgres

Este banco de dados é utilizado para gerenciar informações de clientes e pedidos da lanchonete superburger.


# Documentação do Modelo de Dados

Esta documentação descreve os modelos utilizados na aplicação, suas relações e campos. 

## Modelos

### 1. `BaseUser`

Representa um usuário do sistema.

- **Campos:**
  - `email` (EmailField): Endereço de e-mail do usuário, único.
  - `name` (CharField): Nome do usuário.
  - `cpf` (OneToOneField): Relacionamento com o modelo `Cpf`.
  - `password_confirmation` (CharField): Confirmação de senha.
  
- **Gerenciador:**
  - `CustomUserManager`: Gerencia a criação de usuários e superusuários.

### 2. `Cpf`

Representa o CPF de um usuário.

- **Campos:**
  - `cpf` (CharField): Número do CPF, único e chave primária.
  
- **Métodos:**
  - `get_or_create_cpf(cpf)`: Obtém ou cria um CPF.
  - `clean_cpf(cpf)`: Limpa o CPF, removendo caracteres não numéricos.

### 3. `Product`

Representa um produto disponível para pedido.

- **Campos:**
  - `name` (CharField): Nome do produto.
  - `category` (CharField): Categoria do produto (bebida, lanche, sobremesa, acompanhamento).
  - `description` (CharField): Descrição do produto.
  - `size` (CharField): Tamanho do produto (pequeno, médio, grande).
  - `image` (FileField): Imagem do produto.
  - `amount` (IntegerField): Valor do produto em centavos.

### 4. `Order`

Representa um pedido feito por um usuário.

- **Campos:**
  - `user` (ForeignKey): Relacionamento com o modelo `BaseUser`.
  - `session_token` (CharField): Token de sessão do pedido.
  - `cpf` (ForeignKey): Relacionamento com o modelo `Cpf`.
  - `status` (CharField): Status do pedido (em aberto, processando, recebido, etc.).
  - `created_at` (DateTimeField): Data e hora em que o pedido foi criado.
  - `updated_at` (DateTimeField): Data e hora da última atualização do pedido.

### 5. `OrderItems`

Representa um item de um pedido.

- **Campos:**
  - `order` (ForeignKey): Relacionamento com o modelo `Order`.
  - `product` (ForeignKey): Relacionamento com o modelo `Product`.
  - `quantity` (IntegerField): Quantidade do produto no pedido.
  - `changes` (TextField): Alterações feitas no item do pedido.

### 6. `Transaction`

Representa uma transação de pagamento.

- **Campos:**
  - `order` (ForeignKey): Relacionamento com o modelo `Order`.
  - `external_id` (CharField): ID externo da transação.
  - `status` (CharField): Status da transação (aguardando, pago, falha).
  - `qr_code` (CharField): Código QR gerado para a transação.
  - `amount` (IntegerField): Valor da transação em centavos.
  - `created_at` (DateTimeField): Data e hora em que a transação foi criada.
  - `updated_at` (DateTimeField): Data e hora da última atualização da transação.

## Relações Entre Modelos

- `BaseUser` tem um relacionamento 1:1 com `Cpf`.
- `Order` tem um relacionamento N:1 com `BaseUser` e `Cpf`.
- `OrderItems` tem um relacionamento N:1 com `Order` e `Product`.
- `Transaction` tem um relacionamento N:1 com `Order`.

## Contribuição

..
