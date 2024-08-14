## **Projeto Lógico de Banco de Dados para um sistema de Oficina Mecânica**

<br>

**Introdução**

<br>

Este projeto lógico de banco de dados foi desenvolvido para gerenciar as operações de uma oficina mecânica. Ele abrange o armazenamento e a organização de informações relacionadas a clientes, veículos, equipes de mecânicos, serviços prestados, peças utilizadas e ordens de serviço emitidas. O objetivo principal é proporcionar uma estrutura de dados robusta, eficiente e aderente às melhores práticas de modelagem de banco de dados, garantindo a integridade e a consistência das informações.

<br>

**Objetivos**

<br>

- Organizar e armazenar informações sobre clientes e seus veículos.
- Gerenciar equipes de mecânicos e suas respectivas especialidades.
- Controlar os serviços realizados em cada veículo, bem como as peças utilizadas.
- Registrar e acompanhar as ordens de serviço, desde sua emissão até a conclusão.
- Facilitar a consulta e a recuperação de informações para a tomada de decisões.

<br>

**Estrutura do Projeto**

<br>

O projeto é composto pelas seguintes tabelas principais:

<br>

- Cliente: Armazena informações pessoais dos clientes, como nome, endereço e telefone.
- Veiculo: Contém os detalhes dos veículos, incluindo placa, modelo, marca, ano e a referência ao cliente proprietário.
- Equipe_Responsavel: Registra as equipes de mecânicos responsáveis pelos serviços realizados, associando um nome único a cada equipe.
- Mecanico: Armazena informações sobre os mecânicos, incluindo seu nome, especialidade, endereço e a equipe à qual estão associados.
- Servico: Define os tipos de serviços oferecidos pela oficina, como trocas de óleo, alinhamentos, entre outros, incluindo o valor cobrado pela mão de obra.
- Ordem_de_Servico: Registra as ordens de serviço emitidas para cada veículo, incluindo a data de emissão, status, data de entrega, veículo atendido e a equipe responsável.
- Pecas: Armazena informações sobre as peças disponíveis e utilizadas, como nome, quantidade em estoque e valor unitário.
- Ordem_Pecas: Tabela de junção que associa as peças utilizadas às ordens de serviço específicas, permitindo o controle detalhado de cada item.
- Ordem_Servico: Tabela de junção que relaciona os serviços realizados com as ordens de serviço, permitindo o registro de múltiplos serviços para uma única ordem.

<br>

**Regras de Negócio**

<br>

- Cada cliente pode possuir um ou mais veículos registrados.
- Cada veículo pode ter múltiplas ordens de serviço associadas, mas cada ordem é específica para um único veículo.
- Uma equipe de mecânicos é atribuída a cada ordem de serviço, sendo responsável por realizar os serviços descritos.
- Os serviços realizados em uma ordem de serviço podem ser múltiplos e estão detalhados na tabela de junção Ordem_Servico.
- As peças utilizadas para a realização dos serviços são registradas na tabela de junção Ordem_Pecas, associando cada peça à respectiva ordem.

<br>

**Consultas e Relatórios**

<br>

O esquema lógico facilita a criação de consultas SQL complexas, como:

- Identificação de clientes com veículos em ordens de serviço pendentes ou em progresso.
- Cálculo do valor total de cada ordem de serviço, considerando mão de obra e peças utilizadas.
- Listagem de ordens de serviço emitidas recentemente e suas respectivas equipes responsáveis.
- Geração de relatórios detalhados sobre serviços realizados e peças consumidas por ordem de serviço.

<br>

**Considerações Finais**

<br>

Este projeto foi projetado para ser extensível e capaz de lidar com a complexidade das operações diárias de uma oficina mecânica. A estrutura modular e normalizada garante facilidade de manutenção e escalabilidade, permitindo futuras adaptações conforme as necessidades do negócio evoluam.
