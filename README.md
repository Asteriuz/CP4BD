### 1. _Tabela: DIMPRODUTO_

| Coluna      | Tipo de Dados | Descrição                                                  |
| ----------- | ------------- | ---------------------------------------------------------- |
| COD_PRODUTO | NUMBER        | Código único identificador do produto.                     |
| NOM_PRODUTO | VARCHAR2(100) | Nome do produto.                                           |
| STA_ATIVO   | CHAR(1)       | Status do produto, onde 'S' significa ativo e 'N' inativo. |

- _Descrição_: Esta tabela armazena informações sobre os produtos que foram vendidos. Cada produto é identificado por um código único e tem um nome associado. O status indica se o produto está ativo ou inativo no catálogo de vendas.

---

### 2. _Tabela: DIMCLIENTE_

| Coluna      | Tipo de Dados | Descrição                                                  |
| ----------- | ------------- | ---------------------------------------------------------- |
| COD_CLIENTE | NUMBER        | Código único identificador do cliente.                     |
| NOM_CLIENTE | VARCHAR2(100) | Nome completo do cliente.                                  |
| STA_ATIVO   | CHAR(1)       | Status do cliente, onde 'S' significa ativo e 'N' inativo. |

- _Descrição_: Armazena os dados dos clientes que realizaram pedidos. Cada cliente é identificado por um código único e tem um status de atividade, que indica se o cliente está ativo ou inativo.

---

### 3. _Tabela: DIMVENDEDOR_

| Coluna       | Tipo de Dados | Descrição                               |
| ------------ | ------------- | --------------------------------------- |
| COD_VENDEDOR | NUMBER        | Código único identificador do vendedor. |
| NOM_VENDEDOR | VARCHAR2(100) | Nome completo do vendedor.              |

- _Descrição_: Tabela que armazena os dados dos vendedores que realizaram as vendas. Cada vendedor é identificado por um código único.

---

### 4. _Tabela: DIMTEMPO_

| Coluna     | Tipo de Dados | Descrição                          |
| ---------- | ------------- | ---------------------------------- |
| DATA_VENDA | DATE          | Data em que a venda foi realizada. |
| ANO        | NUMBER        | Ano da venda.                      |
| MES        | NUMBER        | Mês da venda.                      |
| DIA        | NUMBER        | Dia da venda.                      |

- _Descrição_: Esta tabela armazena informações sobre a data da venda, permitindo a análise por dia, mês e ano.

---

### 5. _Tabela: FATOVENDAS_

| Coluna       | Tipo de Dados | Descrição                                                      |
| ------------ | ------------- | -------------------------------------------------------------- |
| COD_PEDIDO   | NUMBER        | Código único identificador do pedido.                          |
| COD_PRODUTO  | NUMBER        | Código do produto vendido (FK para DIMPRODUTO).                |
| COD_CLIENTE  | NUMBER        | Código do cliente que fez o pedido (FK para DIMCLIENTE).       |
| COD_VENDEDOR | NUMBER        | Código do vendedor que realizou a venda (FK para DIMVENDEDOR). |
| DATA_VENDA   | DATE          | Data em que a venda foi realizada (FK para DIMTEMPO).          |
| VAL_UNITARIO | NUMBER(10, 2) | Valor unitário do produto.                                     |
| QTD_VENDIDA  | NUMBER(10, 2) | Quantidade de produtos vendidos.                               |
| VAL_BRUTO    | NUMBER(10, 2) | Valor bruto da venda (valor sem descontos).                    |
| VAL_DESCONTO | NUMBER(10, 2) | Valor total de descontos aplicados.                            |
| VAL_TOTAL    | NUMBER(10, 2) | Valor total da venda (valor bruto - descontos).                |

- _Descrição_: Tabela fato que registra todas as vendas realizadas. Ela contém chaves estrangeiras para as tabelas dimensionais (produto, cliente, vendedor e tempo), além de detalhes financeiros, como valor unitário, quantidade vendida, valor bruto, desconto aplicado e o valor total da venda.

---

### 6. _Tabela: AUDITORIA_DIMENSOES_

| Coluna          | Tipo de Dados | Descrição                                      |
| --------------- | ------------- | ---------------------------------------------- |
| ID_AUDITORIA    | NUMBER        | Identificador único da auditoria.              |
| NOME_TABELA     | VARCHAR2(50)  | Nome da tabela que sofreu a operação auditada. |
| OPERACAO        | VARCHAR2(10)  | Tipo de operação (neste caso, "INSERT").       |
| DADOS_INSERIDOS | CLOB          | Dados da linha que foi inserida.               |
| DATA_OPERACAO   | TIMESTAMP     | Data e hora em que a operação ocorreu.         |

- _Descrição_: Esta tabela armazena informações sobre as operações de inserção realizadas nas tabelas dimensionais, permitindo rastrear mudanças e manter uma trilha de auditoria para a inserção de dados.

---

### Considerações Finais:

- _Chaves Primárias_: Cada tabela dimensional possui uma chave primária (COD_PRODUTO, COD_CLIENTE, COD_VENDEDOR, DATA_VENDA).
- _Chaves Estrangeiras_: A tabela FATOVENDAS utiliza chaves estrangeiras (COD_PRODUTO, COD_CLIENTE, COD_VENDEDOR, DATA_VENDA) para garantir a integridade referencial com as tabelas dimensionais.
- _Atributos de Atividade_: As tabelas DIMPRODUTO e DIMCLIENTE possuem um campo STA_ATIVO para indicar se os registros estão ativos, facilitando o gerenciamento de dados históricos.
