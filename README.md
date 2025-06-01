# Processo seletivo do Grupo Adriano Cobuccio
Desenvolvimento de um projeto para pesquisa de criptomoedas por meio de uma API externa, permitindo que o usuário favorite ativos localmente para acessá-los com mais facilidade, além de oferecer a visualização detalhada de suas informações por meio de gráficos interativos.

# Arquitetura

Este módulo segue uma arquitetura baseada em **Clean Architecture**, com adaptações para manter simplicidade e modularidade. A estrutura é replicada em todos os módulos do projeto, seguindo o padrão abaixo:

```
<nome_do_módulo>/
├── domain/
│   ├── entities/
│   └── repository/
├── infra/
│   ├── datasource/
│   └── repository/
├── external/
│   ├── converters/
│   └── datasource/
├── presentation/
│   └── pages/
│       ├── <nome_da_tela>/
│       │   ├── <nome_da_tela>_page.dart
│       │   ├── widgets/
│       │   └── cubit/
│       └── ...
```

## Camadas do Módulo

### `domain/`
Contém as **entidades** e os **contratos de repositório**, totalmente isolados de dependências externas.

### `infra/`
Implementa os repositórios definidos no domínio e define a comunicação com fontes de dados (como APIs ou banco local).

### `external/`
Faz a ponte com o ambiente externo. Inclui as **implementações dos data sources** e os **conversores** entre `models` e `entities`.

### `presentation/`
Responsável pela interface do usuário e gerenciamento de estado. Consome diretamente os repositórios, **sem uso de use cases**, para manter o fluxo mais direto.

Essa organização promove separação de responsabilidades, reuso de código e facilita testes e manutenção em projetos de médio a grande porte.

# Módulos do App

O aplicativo é dividido em módulos independentes, cada um com suas responsabilidades bem definidas e seguindo a arquitetura proposta:

## CoreModule
Módulo central da aplicação. É responsável por fornecer serviços e dependências globais que são utilizados em diferentes partes do app, como o cliente HTTP (Dio), armazenamento local (Hive), acesso ao ambiente de configuração remoto (FirebaseRemoteConfig).

Cada módulo pode ser desenvolvido e testado isoladamente, promovendo escalabilidade e flexibilidade.

## SplashModule
Tela de introdução do aplicativo para o carregamento de dependências.

## HomeModule
Tela principal com navegação para os demais módulos.

## CryptoModule
Responsável pelas operações CRUD das criptomoedas favoritas e pelas requisições relacionadas as criptomoedas a API.

# Pacotes utilizdos

## Injeção de Dependência e Navegação (**flutter_modular**)
Foi utilizado o pacote **flutter_modular** para gerenciar tanto a **injeção de dependências** quanto a **navegação** do projeto. O pacote foi escolhido por sua simplicidade e flexibilidade, oferecendo uma solução unificada para essas duas responsabilidades.

## Gerenciamento de estado (**flutter_triple**)
Este projeto utiliza o **flutter_triple** para gerenciamento de estado. Baseado em princípios reativos e funcionais, o pacote oferece uma abordagem simples e escalável, com foco na separação entre lógica de negócio e interface. Utiliza o padrão Store para centralizar o estado, controlando explicitamente os status de carregando, sucesso e erro, resultando em um fluxo previsível e código mais limpo e testável.


## Requisições HTTP (**dio**)
O projeto usa a biblioteca Dio para requisições HTTP. Ela oferece recursos como interceptadores, manipulação de erros e cancelamento de requisições, tornando o processo mais flexível e robusto.

## Programação Funcional e Fluxo Seguro com Either (**dartz**)
Usamos a biblioteca **dartz** para aplicar programação funcional, destacando a classe **Either**. Ela representa falhas e sucessos de forma segura e explícita, evitando exceções e garantindo tratamento adequado dos erros, o que deixa o código mais limpo, previsível e fácil de testar.

## Armazenamento local (**hive_ce**)
O projeto utiliza **hive_ce** para armazenamento local. Essa versão estendida do Hive é leve e rápida, ideal para persistir dados sem a complexidade de bancos relacionais. Suporta criptografia, adapters personalizados e integração simples com Flutter, garantindo desempenho e facilidade no gerenciamento offline.

## Gráficos Interativos com (**syncfusion_flutter_charts**)
Para exibir gráficos, o projeto usa **syncfusion_flutter_charts**, que oferece diversos tipos personalizáveis e de alta performance, facilitando a visualização clara e interativa de dados analíticos e métricas.

## Gerenciamento Remoto de Configurações (**firebase_remote_config**)
O **firebase_remote_config** permite alterar configurações do app sem novas publicações. Por exemplo, a **apiKey** usada nas integrações está armazenada no Remote Config, garantindo segurança e facilidade para atualizar chaves e parâmetros em tempo real, sem recompilar o app.

## Internacionalização e formatação de dados (**intl**)
O pacote **intl** é usado para formatar datas, números e moedas conforme a localidade do usuário, garantindo que os dados estejam apresentados no formato correto e melhorando a experiência em diferentes regiões.

## Atualização por pull-to-refresh (**pull_to_refresh_flutter3**)

Para facilitar a atualização de listas e conteúdos, utilizamos o **pull_to_refresh_flutter3**, que oferece uma implementação simples e customizável do gesto “pull-to-refresh”, permitindo atualizações intuitivas com animações e callbacks integrados ao Flutter.

# API de Dados das Criptomoedas
Para obter as informações das criptomoedas, este projeto utiliza a API da **CoinCap**, disponível em https://pro.coincap.io/api-docs. Nesta API, destacamos duas funções principais que são utilizadas no app para coletar dados essenciais sobre os ativos digitais.

## Funções utilizadas

### 🔹 /assets
Essa função é responsável por listar todos os ativos disponíveis no mercado. Ela retorna informações detalhadas, como nome, símbolo, preço atual, volume negociado, entre outros dados importantes para a visualização geral das criptomoedas.

### 🔹 /assets/{slug}/history
Esta função é usada para consultar o histórico de preços de uma criptomoeda específica, identificada pelo seu slug. Ela permite obter dados de variação e tendências ao longo do tempo, essenciais para a construção de gráficos e análises no aplicativo.

# Configuração da API e Limitações
A chave de acesso (**apiKey**) para a API da **CoinCap** está armazenada no **Firebase Remote Config**, garantindo maior segurança e facilidade para atualizações sem a necessidade de novas versões do aplicativo.

Devido às limitações do plano gratuito da API, não foi possível implementar a atualização dos dados via **WebSocket** para receber informações em tempo real. Além disso, optou-se por não utilizar uma solução alternativa menos eficiente, como consultas periódicas à API, tanto para evitar sobrecarga quanto por conta do número limitado de consultas permitidas por **apiKey** no plano gratuito, garantindo assim a qualidade e estabilidade do aplicativo.

Para atualizar as informações exibidas nas páginas inicial e de favoritas, o usuário deve utilizar o gesto de pull-to-refresh, implementado com o pacote **pull_to_refresh_flutter3**. Esse recurso permite que o usuário atualize manualmente os dados ao “puxar” a lista para baixo, acionando uma atualização intuitiva e visualmente agradável.

# Tema do Aplicativo
O tema da aplicação foi desenvolvido seguindo o esquema do Material You (Material 3), utilizando as diretrizes e recursos disponíveis no site https://material-foundation.github.io/material-theme-builder/. Essa abordagem garante uma interface moderna, harmoniosa e adaptável, que proporciona uma experiência visual consistente e agradável, alinhada às melhores práticas de design do Google.

# Configuração do Firebase para rodar o código-fonte
Para executar o projeto pelo código-fonte, é necessário configurar o **Firebase**. Caso queira executar o app localmente, entre em contato comigo enviando seu e-mail para que eu possa adicioná-lo ao projeto no **Firebase**. Após isso, basta executar o comando abaixo para configurar o Firebase no seu ambiente de desenvolvimento:

```bash
flutterfire configure
```
E caso as consultas gratuitas acabem, tornando impossivel ver as informações das moedas, bastará mudá-la no painel do **Firebase Remote Config**.