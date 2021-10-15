# capyba_challenge_frontend

Desafio App Flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Tasks
  ## Primeira Etapa
    [x] Cadastro e login via email
    [x] Exigir selfie do usuário no cadastro
    [x] Exigir o aceite de termos de uso e políticas de privacidade
    [x] O usuário poderá ler o termo e política
    [x] Após o login da pessoa, caso ela feche o app e abra de novo, o app deve continuar logado e mostrar a página de home
  
  ## Segunda Etapa
    [x] Área logado contém duas abas, "Home" e "Restrito"
    [x] Área de Home é acessível para qualquer pessoa logada
    [x] Área Restrita só é acessível para pessoas que tenham confirmado seu email

  ## Terceira Etapa
    [x] Implementar uma página "Meu Perfil", acessível via um menu lateral
    [x] Na página de "Meu Perfil", a pessoa poderá editar suas informações de cadastro

  ## Quarta Etapa
    [x] Criar uma collection "home" onde haverá documentos a serem mostrados na aba "Home" do app
    [x] Criar uma collection "restricted" onde haverá documentos a serem mostrados na aba "Restrito" do app
    [x] As informações das collections e como serão exibidos (layout) os documentos em cada aba fica a critério de vocês

  ## Quinta Etapa
    [] Adicionar uma opção no menu lateral "Validar Email" que direcionará o usuário para a tela de confirmação de e-mail
    [] Na tela de confirmação de e-mail, a pessoa deverá clicar num botão para receber um token
    [] Após clicar no botão de receber um token, deve abrir um modal pedindo para a pessoa digitar o token  recebido por e-mail e efetuar a confirmação

    OBSERVAÇÃO: Quinta etapa concluída de maneira diferente, ao clicar em "Validar Email" é enviado um email com uma URL que ao ser clicado irá validar o email.

### Sobre o app
  Descrição
    A ideia do App é o usuário poder registrar-se com um email e assim criar eventos públicos ou privados para que outros usuários possam ver.

  Regras de negócio
    - Para criar e ver eventos privados o email do usuário deve ser validado, caso não esteja, o usuário receberá um aviso para validar seu email;
    - O usuário pode a qualquer momento alterar suas informações através do menu lateral ao clicar em meu perfil;
    - Os eventos públicos são sempre visíveis para qualquer usuário;
    - Para registrar-se o usuário deve aceitar os termos de política de privacidade.
