# App HamburgueriaZ com Flutter

Desenvolvido como atividade prática da disciplina **Desenvolvimento Mobile** no curso de **Sistemas de Informação**.

Este projeto é uma implementação de um aplicativo para hamburgueria em **Flutter** que permite aos clientes montarem seus pedidos com diversos adicionais e enviá-los por e-mail.

<img src="./assets/images/demo.gif" alt="Demonstração do app HamburgueriaZ" width="300">

## Tecnologias Utilizadas

- **Flutter**
- **Dart**
- **Android Studio** (para emulação)
- **url_launcher** (para integração com e-mail)

## Estrutura de Pastas

```
📦 hamburgueriaz
 ┣ 📂 android
 ┣ 📂 assets
 ┃ ┗ 📂 images
 ┃   ┗ 🖼️ logo.png
 ┣ 📂 ios
 ┣ 📂 lib
 ┃ ┣ 📜 main.dart
 ┃ ┗ 📜 widgets/
 ┣ 📂 test
 ┣ 📜 .gitignore
 ┣ 📜 pubspec.lock
 ┣ 📜 pubspec.yaml
 ┣ 🖼️ README.md
 ┗ 📜 LICENSE
```

## Funcionalidades Principais

- Seleção de adicionais para hambúrguer (Bacon, Queijo, Onion Rings)
- Controle de quantidade com incremento/decremento
- Cálculo automático do valor total
- Envio do pedido por e-mail com resumo
- Banner com logo da hamburgueria

## Como Usar

1. Clone o repositório:

   ```bash
   git clone https://github.com/Alberesbass/app-hamburgueria.git
   ```

2. Acesse o diretório do projeto:

   ```bash
   cd app-hamburgueria
   ```

3. Instale as dependências:

   ```bash
   flutter pub get
   ```

4. Execute o aplicativo:

   ```bash
   flutter run
   ```

5. Para gerar APK:

   ```bash
   flutter build apk --release
   ```

## Requisitos do Sistema

- Flutter SDK (versão 3.24.4 ou superior)
- Android Studio com emulador configurado
- Dispositivo Android ou iOS para teste (ou emulador)

## Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](./LICENSE) para mais informações.

---

Desenvolvido por [Alberes](https://github.com/Alberesbass)
