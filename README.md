# Aplicativo de Gerenciamento de Manutenção de Equipamentos
Este é um aplicativo construído em Flutter 3.4 que utiliza o Cloud Firestore para persistir dados. O objetivo do aplicativo é gerenciar as manutenções de equipamentos em diversas unidades e departamentos.

**Funcionalidades** 
* Adicionar, visualizar, atualizar e excluir unidades;
* Adicionar, visualizar, atualizar e excluir departamentos;
* Adicionar, visualizar, atualizar e excluir equipamentos;
* Adicionar, visualizar, atualizar e excluir manutenções;
* Associar equipamentos a departamentos e departamentos a unidades;
* Visualizar todas as manutenções de um equipamento em particular;
* Visualizar todas as manutenções de um departamento em particular;
* Visualizar todas as manutenções de uma unidade em particular.

**Instalação**

Para rodar o aplicativo localmente, siga os seguintes passos:

* Clone este repositório;
* Certifique-se de ter o Flutter instalado em seu ambiente de desenvolvimento;
* Execute o comando flutter pub get para instalar todas as dependências do projeto;
* Configure suas credenciais do Cloud Firestore no arquivo lib/main.dart;
* Execute o aplicativo com o comando 'flutter run'.

**Dependências**

Este aplicativo utiliza as seguintes dependências:

* mobx: ^2.1.3
* flutter_mobx: ^2.0.6+5
* email_validator: ^2.1.17
* string_validator: ^0.3.0
* intl: ^0.17.0
* cloud_firestore: ^3.5.1
* firebase_core: ^1.24.0
* firebase_auth: ^3.11.2
  
**Estrutura do Banco de Dados**

O banco de dados é organizado da seguinte forma:

* Coleção "units": contém documentos representando as unidades;
* Coleção "departments": contém documentos representando os departamentos;
* Coleção "equipments": contém documentos representando os equipamentos;
* Coleção "maintenances": contém documentos representando as manutenções;
* Campo "department" em documentos da coleção "equipamentos": contém a referência ao documento do departamento a que o equipamento pertence;
* Campo "unit" em documentos da coleção "departamentos": contém a referência ao documento da unidade a que o departamento pertence;
* Campo "equipment" em documentos da coleção "manutencoes": contém a referência ao documento do equipamento ao qual a manutenção se aplica.

