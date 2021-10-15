# capyba_challenge_frontend

Desafio App Flutter Android.

Para cumprir o desafio foi desenvolvido um app de criação de eventos que terá funcionalidades que englobará os pontos(ou a maior parte) propostos em cada etapa do desafio.

## 1 - Framework

O proposto desafio tinha como requisito desenvolver o App com Flutter.

## 2 - Tasks

1 - Primeira Etapa
    [x] Cadastro e login via email
    [x] Exigir selfie do usuário no cadastro
    [x] Exigir o aceite de termos de uso e políticas de privacidade
    [x] O usuário poderá ler o termo e política
    [x] Após o login da pessoa, caso ela feche o app e abra de novo, o app deve continuar logado e mostrar a página de home
  
2 - Segunda Etapa
    [x] Área logado contém duas abas, "Home" e "Restrito"
    [x] Área de Home é acessível para qualquer pessoa logada
    [x] Área Restrita só é acessível para pessoas que tenham confirmado seu email

3 - Terceira Etapa
    [x] Implementar uma página "Meu Perfil", acessível via um menu lateral
    [x] Na página de "Meu Perfil", a pessoa poderá editar suas informações de cadastro

4 - Quarta Etapa
    [x] Criar uma collection "home" onde haverá documentos a serem mostrados na aba "Home" do app
    [x] Criar uma collection "restricted" onde haverá documentos a serem mostrados na aba "Restrito" do app
    [x] As informações das collections e como serão exibidos (layout) os documentos em cada aba fica a critério de vocês

5 - Quinta Etapa
    [] Adicionar uma opção no menu lateral "Validar Email" que direcionará o usuário para a tela de confirmação de e-mail
    [] Na tela de confirmação de e-mail, a pessoa deverá clicar num botão para receber um token
    [] Após clicar no botão de receber um token, deve abrir um modal pedindo para a pessoa digitar o token  recebido por e-mail e efetuar a confirmação

    OBSERVAÇÃO: Quinta etapa concluída de maneira diferente, ao clicar em "Validar Email" é enviado um email com uma URL que ao ser clicado irá validar o email.

## 3 - Regra de negócio

- Para criar e ver eventos privados o email do usuário deve ser validado, caso não esteja, em certas ações tomadas dentro do app o usuário receberá um aviso para validar seu email;
- O usuário pode a qualquer momento alterar suas informações através do menu lateral ao clicar em "Meu perfil";
- Os eventos públicos são sempre visíveis para qualquer usuário logado;
- Para registrar-se o usuário deve aceitar os termos de política de privacidade;
- Para registrar-se o usuário deve tirar uma foto;
- Caso o usuário mude o email, automaticamente será considerado um usuário sem o email validado;
- O usuário permanecerá logado ao fechar e abrir o app, a menos que ele faça logOut;
- Para alteração de email e senha o usuário deve se re-autenticar.

## 4 - Como rodar o projeto

### 1 - Seguir o passo a passo para instalação e configuração do flutter e suas variáveis de ambiente

[Instalar Flutter](https://flutter.dev/docs/get-started/install)

### 2 - Baixar o projeto

Pode ser feito o download do ZIP pelo github

### 3 - Dentro do projeto

Ao entrar na pasta do projeto, rodar no terminal(pelo VsCode, por exemplo) ```flutter pub get```

### 4 - Criar um projeto Android no Firebase

[Link do passo a passo](https://firebase.google.com/docs/functions/get-started?hl=pt)
Não esquecer de: 
Pôr arquivo 'google-services.json' na seguinte pasta -> 'android/app/'
Habilitar autenticação por E-mail
Habilitar Firestore Database
Habilitar Storage
