# Meu Primerio App

A `AppDelegate` é a classe principal de uma aplicação iOS, responsável por gerenciar o ciclo de vida do aplicativo. Ela interage diretamente com o **UIKit** para responder a eventos importantes, como o lançamento do app, transições para o segundo plano e encerramento.

-----

## Estrutura da `AppDelegate`

### Importações e Anotações

A classe `AppDelegate` geralmente começa com a importação do framework `UIKit` e a anotação `@main`.

```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
// ...
}
```

  * `import UIKit`: Este comando traz todo o conjunto de ferramentas e classes necessárias para construir a interface de usuário e gerenciar o ciclo de vida do aplicativo.
  * `@main`: Essa anotação é vital. Introduzida no **SwiftUI** e depois adotada pelo **UIKit**, ela marca a `AppDelegate` como o ponto de entrada principal do aplicativo. Em outras palavras, quando seu app é iniciado, o sistema sabe que deve começar a execução a partir desta classe.

### Protocolos

A `AppDelegate` implementa dois protocolos: `UIResponder` e `UIApplicationDelegate`.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
// ...
}
```

  * `UIResponder`: É a classe base para objetos que podem responder a eventos do usuário e manipular cadeias de eventos (como toques na tela e movimentos). A `AppDelegate` herda essa capacidade.
  * `UIApplicationDelegate`: Este é o protocolo mais importante para a `AppDelegate`. Ele define um conjunto de métodos que o seu aplicativo pode implementar para reagir a eventos do sistema, como o início ou término da execução do app.

-----

## Métodos Essenciais

A `AppDelegate` contém vários métodos que o sistema chama em momentos específicos do ciclo de vida do aplicativo.

### `application(_:didFinishLaunchingWithOptions:)`

Este é o primeiro método a ser chamado quando o aplicativo é iniciado.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
}
```

  * **Finalidade**: É o lugar ideal para configurar sua aplicação, como inicializar bibliotecas de terceiros, configurar bancos de dados ou realizar qualquer configuração inicial antes que a interface de usuário seja exibida. O retorno `true` indica ao sistema que a inicialização do app foi bem-sucedida.

### Métodos de Gerenciamento de Cenas (iOS 13+)

A partir do iOS 13, o conceito de **"Scene"** foi introduzido para suportar multi-janelas em iPads e macOS.

#### `application(_:configurationForConnecting:options:)`

Este método é chamado quando uma nova cena (ou janela) é criada.

```swift
func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}
```

  * **Finalidade**: Você o usa para fornecer uma configuração para a nova cena, como qual `Info.plist` usar para o layout ou como ela deve se comportar. O retorno `UISceneConfiguration` define a base para a nova janela.

#### `application(_:didDiscardSceneSessions:)`

Este método é invocado quando o usuário descarta uma cena (por exemplo, fechando uma janela no iPad).

```swift
func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
```

  * **Finalidade**: É o local para liberar recursos associados à cena que está sendo fechada. Por exemplo, se uma cena era responsável por um arquivo específico, você pode fechar o arquivo aqui.

---

## O que é a `SceneDelegate`?

A `SceneDelegate` é a classe responsável por gerenciar o ciclo de vida de uma "cena" em um aplicativo iOS. Introduzida no iOS 13, ela divide as responsabilidades que antes eram apenas da `AppDelegate`. Enquanto a `AppDelegate` lida com o ciclo de vida do aplicativo como um todo (o processo), a `SceneDelegate` gerencia o ciclo de vida das janelas individuais.

Isso é fundamental para aplicativos que suportam múltiplas janelas, como no **iPadOS** e **macOS Catalyst**, onde o usuário pode ter mais de uma instância do seu app aberta ao mesmo tempo.

### Estrutura e Protocolos

A `SceneDelegate` também é uma subclasse de `UIResponder` e implementa o protocolo `UIWindowSceneDelegate`.

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
// ...
}
```

  * **`UIWindowSceneDelegate`**: Este protocolo define os métodos que permitem que o seu aplicativo reaja a eventos do ciclo de vida de uma cena específica, como a conexão, desconexão ou transições de estado (ativo, inativo, em segundo plano).

-----

## Métodos Essenciais da `SceneDelegate`

Os métodos da `SceneDelegate` são acionados em momentos específicos do ciclo de vida de uma cena, permitindo que você responda a eventos de forma granular.

### `scene(_:willConnectTo:options:)`

Este é o primeiro método chamado quando uma nova cena (janela) está sendo criada e conectada ao aplicativo.

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use este método para configurar e anexar a UIWindow 'window' à UIWindowScene 'scene'.
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    // 1. Criar uma nova UIWindow usando a scene
    let window = UIWindow(windowScene: windowScene)
    
    // 2. Criar e atribuir um ViewController inicial
    let viewController = ViewController() // Substitua pelo seu ViewController
    window.rootViewController = viewController
    
    // 3. Tornar a janela a janela principal e visível
    self.window = window
    window.makeKeyAndVisible()
}
```

  * **Finalidade**: Este é o local principal para configurar a interface de usuário da sua cena. É onde você cria a `UIWindow`, atribui a ela a `rootViewController` (a tela inicial do app) e a torna visível.

### `sceneDidDisconnect(_:)`

Chamado quando uma cena é desconectada do aplicativo pelo sistema. Isso pode acontecer quando o usuário fecha uma janela ou quando o sistema libera recursos.

```swift
func sceneDidDisconnect(_ scene: UIScene) {
    // Libere quaisquer recursos associados a esta cena que podem ser recriados
    // na próxima vez que a cena se conectar.
}
```

  * **Finalidade**: Use este método para liberar recursos que são específicos da cena que está sendo descartada, como fechar conexões de rede ou arquivos abertos, garantindo que o seu aplicativo não consuma memória desnecessariamente.

### `sceneDidBecomeActive(_:)`

Invocado quando a cena transita de um estado inativo para um estado ativo. Uma cena é considerada "ativa" quando está visível e o usuário pode interagir com ela.

```swift
func sceneDidBecomeActive(_ scene: UIScene) {
    // Use este método para reiniciar quaisquer tarefas que foram pausadas
    // quando a cena estava inativa.
}
```

  * **Finalidade**: Ideal para iniciar tarefas que só devem ser executadas quando o app está em primeiro plano e interativo. Por exemplo, iniciar animações, atualizar dados ou reiniciar a entrada de dados.

### `sceneWillResignActive(_:)`

Chamado quando a cena está prestes a sair do estado ativo para o estado inativo. Isso pode ocorrer devido a interrupções temporárias, como uma chamada telefônica, ou quando o usuário muda para outro aplicativo.

```swift
func sceneWillResignActive(_ scene: UIScene) {
    // Chamado quando a cena transitará de um estado ativo para um estado inativo.
}
```

  * **Finalidade**: Ótimo para pausar tarefas que não precisam ser executadas em segundo plano, como parar animações ou salvar o estado atual para que o usuário possa retomar de onde parou.

### `sceneWillEnterForeground(_:)`

Acionado quando a cena está prestes a transitar do segundo plano para o primeiro plano.

```swift
func sceneWillEnterForeground(_ scene: UIScene) {
    // Chamado quando a cena transita do segundo plano para o primeiro plano.
}
```

  * **Finalidade**: Use este método para "acordar" seu aplicativo. Por exemplo, você pode revalidar o token do usuário ou reativar a interface de usuário que estava em segundo plano.

### `sceneDidEnterBackground(_:)`

Este método é chamado quando a cena transita do primeiro plano para o segundo plano. O sistema pode encerrar seu aplicativo a qualquer momento enquanto ele estiver em segundo plano.

```swift
func sceneDidEnterBackground(_ scene: UIScene) {
    // Use este método para salvar dados, liberar recursos compartilhados e armazenar
    // informações de estado da cena o suficiente para restaurá-la para seu estado atual.
}
```

  * **Finalidade**: Este é o momento crucial para salvar qualquer dado que o usuário tenha modificado e liberar recursos que não são essenciais, como grandes arquivos de mídia ou conexões de rede. Isso garante que o aplicativo possa ser restaurado corretamente e que o sistema possa liberar memória.

-----

## O que é uma `ViewController`?

A `ViewController` é a **principal classe de uma tela** em uma aplicação iOS. Ela age como um intermediário entre a interface de usuário (o `View`) e os dados (`Model`), seguindo o padrão de design **MVC** (Model-View-Controller). Sua responsabilidade é gerenciar o ciclo de vida da tela, manipular as interações do usuário e exibir os dados corretamente.

Cada tela em seu aplicativo, como a tela de login, a tela principal ou a tela de configurações, geralmente é controlada por sua própria `ViewController`.

### Estrutura e Protocolos

A `ViewController` é uma subclasse de `UIViewController`, que é a classe fundamental para gerenciar telas no iOS.

```swift
class ViewController: UIViewController {
// ...
}
```

  * **`UIViewController`**: Esta é a classe base do framework **UIKit** para gerenciar a interface de usuário. Ela fornece todos os métodos e propriedades necessários para carregar, exibir e liberar uma `view` (uma tela), e para responder a eventos do sistema e do usuário.

-----

## Métodos Essenciais do Ciclo de Vida

A `ViewController` tem um ciclo de vida bem definido, com métodos que são chamados em momentos específicos. Você pode sobrescrever esses métodos para executar ações em cada etapa.

### `viewDidLoad()`

Este é o método mais comum e importante. Ele é chamado **uma única vez** quando a `view` da `ViewController` é carregada na memória pela primeira vez.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // Faça qualquer configuração inicial aqui.
}
```

  * **Finalidade**: É o local ideal para realizar **configurações iniciais** que não mudam durante a vida útil da tela. Por exemplo:
      * **Configuração da UI**: Adicionar subviews, configurar cores de fundo ou ajustar constraints.
      * **Carregamento de Dados**: Fazer uma requisição de rede para buscar dados que serão exibidos na tela.
      * **Configuração de Gestos**: Adicionar reconhecedores de gestos (como toques ou swipes) à tela.

### Outros Métodos Importantes

  * `viewWillAppear(_:)`: Chamado **toda vez** que a `view` está prestes a aparecer na tela. Use-o para tarefas que precisam ser atualizadas antes da tela ser visível, como recarregar dados de uma lista.
  * `viewDidAppear(_:)`: Chamado **toda vez** que a `view` já apareceu na tela. Útil para iniciar animações ou tarefas que devem ocorrer apenas depois que a tela estiver completamente visível para o usuário.
  * `viewWillDisappear(_:)`: Chamado quando a `view` está prestes a ser removida da tela. Use-o para salvar o estado da tela ou para fechar teclados.
  * `viewDidDisappear(_:)`: Chamado quando a `view` já foi completamente removida da hierarquia de visualização. É o local para parar tarefas em andamento, como parar animações.

Entender a diferença entre esses métodos é crucial para criar aplicativos eficientes e sem bugs. Por exemplo, colocar uma chamada de API em `viewDidLoad` é eficiente, pois ela só será executada uma vez. Se a mesma chamada estivesse em `viewWillAppear`, ela seria executada toda vez que o usuário voltasse para a tela, o que poderia causar um consumo desnecessário de dados e bateria.

---

## O que é o `Main.storyboard`?

No ecossistema de desenvolvimento iOS, o **`Main.storyboard`** não é um arquivo de código, mas sim um arquivo de interface que descreve o fluxo visual e o layout das telas do seu aplicativo.

O `Main.storyboard` é um arquivo **XML** que armazena informações sobre a interface de usuário de uma aplicação. Ele funciona como uma "planta baixa" visual, permitindo que você crie e organize telas (`View Controllers`), elementos de interface (`UIButtons`, `UILabels`, etc.) e as transições entre eles (`Segues`).

Em vez de escrever código para posicionar cada botão e label, você pode usar uma interface gráfica no **Xcode** para arrastar e soltar esses elementos.

### Componentes Principais

* **View Controllers**: Representam cada tela do seu aplicativo. No Storyboard, cada `View Controller` é uma cena distinta.
* **Views**: São os elementos visuais que compõem a interface, como botões, rótulos de texto e campos de entrada.
* **Segues**: São as setas que ligam um `View Controller` a outro. Elas definem a transição de uma tela para a próxima, seja ao clicar em um botão ou após uma ação específica.
* **Auto Layout**: Um sistema de restrições que garante que sua interface se adapte a diferentes tamanhos de tela (iPhones e iPads de diferentes gerações), orientações (retrato e paisagem) e tamanhos de texto dinâmico.

### Como Funciona?

Quando o seu aplicativo é iniciado, o sistema carrega o `Main.storyboard` e cria as instâncias dos `View Controllers` e das `views` que ele descreve. As **`Segues`** também são configuradas, aguardando serem acionadas para executar a transição entre telas.

É importante notar que o uso de Storyboards é uma abordagem tradicional no iOS. Embora ainda sejam muito usados, muitos desenvolvedores mais experientes também optam por construir interfaces inteiramente por código, especialmente em projetos grandes e complexos, para ter um controle mais preciso e facilitar o trabalho em equipe. No entanto, para iniciantes e protótipos rápidos, o `Main.storyboard` é uma ferramenta poderosa e intuitiva.

---

## O que é a Pasta `Assets`?

A pasta `Assets.xcassets` (comumente chamada apenas de `Assets`) é um contêiner no seu projeto do Xcode usado para gerenciar de forma organizada todos os recursos visuais do seu aplicativo, como imagens, ícones de aplicativo e cores.

Ela atua como um catálogo central onde você pode adicionar, configurar e otimizar recursos sem precisar lidar diretamente com arquivos individuais.

### Componentes Principais e Finalidade

* **Imagens**: Em vez de simplesmente arrastar um arquivo `.png` para o projeto, você o adiciona na pasta `Assets`. O Xcode então gerencia automaticamente as diferentes resoluções de imagem (`@1x`, `@2x`, `@3x`) para garantir que as imagens fiquem nítidas em todos os dispositivos Apple, independentemente da densidade de pixels da tela.
* **Ícone do Aplicativo**: O ícone que aparece na tela inicial do seu dispositivo é gerenciado aqui. A pasta `Assets` permite que você forneça variações do ícone para diferentes tamanhos e contextos (como na tela de início, nas notificações ou na App Store), garantindo que ele se adapte corretamente.
* **Cores**: Você pode definir cores personalizadas e reutilizáveis em seu projeto. Ao adicionar uma cor na pasta `Assets`, ela pode ser acessada por nome em todo o seu aplicativo, tanto no código quanto no Storyboard. Isso facilita a manutenção e garante uma paleta de cores consistente, especialmente ao trabalhar com modos claro e escuro.

### Por que Usar `Assets`?

1.  **Organização**: Mantém todos os recursos visuais em um único lugar centralizado, tornando o projeto mais limpo e fácil de navegar.
2.  **Otimização Automática**: O Xcode otimiza as imagens para o formato correto e as empacota de forma eficiente no seu aplicativo, o que ajuda a reduzir o tamanho final do arquivo.
3.  **Suporte a Múltiplas Resoluções**: O sistema sabe automaticamente qual versão de imagem usar para cada dispositivo, eliminando a necessidade de escrever código manual para isso.
4.  **Suporte a `Dark Mode`**: A pasta `Assets` facilita a configuração de variações de cores e imagens para os modos claro e escuro, permitindo que seu aplicativo se adapte dinamicamente à preferência do usuário.

Em resumo, a pasta `Assets` é uma ferramenta essencial que simplifica o gerenciamento de recursos visuais, garantindo que seu aplicativo seja eficiente e visualmente consistente em todos os dispositivos iOS.

---

## `SignInViewController`

### 1\. Configuração no `SceneDelegate` (Ponto de Partida)

Mantemos a configuração inicial, definindo a **`SignInViewController`** como a **`rootViewController`** (tela raiz) do aplicativo.

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // ... Código para criar a janela (UIWindow) ...
    // Define a SignInViewController como a primeira tela
    window?.rootViewController = SignInViewController()
    // ... Código para exibir a janela ...
}
```

-----

### 2\. Implementação da `SignInViewController`

A classe agora incluirá um terceiro elemento, o **`sendButton`**, e suas regras de posicionamento (Constraints).

#### Guia Rápido de Âncoras do Auto Layout:

| Âncora | Significado |
| :--- | :--- |
| `leadingAnchor` | Esquerda (início) |
| `trailingAnchor` | Direita (fim) |
| `topAnchor` | Cima |
| `bottomAchor` | Baixo |
| `centerYAnchor` | Eixo Y | Centro Vertical |
| `centerXAnchor` | Eixo X | Centro Horizontal |
| `heightAnchor` | Altura |
| `widthAnchor` | Largura |

#### A. Criação dos Elementos de UI (Adicionando o Botão)

Adicionamos a definição do `sendButton` e garantimos que todos os elementos tenham **`translatesAutoresizingMaskIntoConstraints = false`**.

```swift
// Elementos de Texto (emailTextField e passwordTextField) ...

let sendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Entrar", for: .normal)
    button.backgroundColor = .blue 
    button.setTitleColor(.white, for: .normal)
    // ESSENCIAL para usar constraints
    button.translatesAutoresizingMaskIntoConstraints = false 
    return button
}()
```

#### B. Configuração em `viewDidLoad()`

Em `viewDidLoad()`, adicionamos o novo botão à view e definimos suas constraints.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.orange
    
    // Adicionamos os elementos à view
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(sendButton) // ⬅️ Novo elemento

    let emailConstraints = [ /* ... regras de email ... */ ]
    let passwordConstraints = [
        // Posicionamento baseado no campo email
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
        // ... outras regras ...
    ]
    
    // ➡️ Novas Constraints do Botão:
    let sendButtonConstraints = [
        // Distância de 50 pontos da borda esquerda da View
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
        // Distância de 50 pontos da borda direita da View (usando valor negativo)
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
        // O TOPO do botão fica 10 pontos ABAIXO de passwordTextField
        sendButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0), 
        // Define a altura do botão
        sendButton.heightAnchor.constraint(equalToConstant: 50.0)
    ]
    
    // Ativa todas as regras
    NSLayoutConstraint.activate(emailConstraints)
    NSLayoutConstraint.activate(passwordConstraints)
    NSLayoutConstraint.activate(sendButtonConstraints) // ⬅️ Ativa constraints do botão
}
```

\***Nota sobre a Constraint do Botão:** O trecho original (`sendButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10.0)`) posicionaria o botão para fora da tela (10 pontos abaixo da borda inferior). Para um botão de login típico, o correto é ancorá-lo abaixo do último campo de texto (`passwordTextField`), como ajustado no código acima:

```swift
sendButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30.0)
```

### 3\. Manipulação do Evento de Clique do Botão (Ação)

Para que o botão **`sendButton`** seja funcional, precisamos definir qual método será chamado quando o usuário tocá-lo, além de implementar esse método.

#### A. Anexando o Método de Ação (`addTarget`)

O método `addTarget` anexa um evento (`.touchUpInside`) a um método específico (`#selector`) dentro do controlador (`self`).

```swift
override func viewDidLoad() {
    // ... Ativação das Constraints ...
    NSLayoutConstraint.activate(emailConstraints)
    NSLayoutConstraint.activate(passwordConstraints)
    NSLayoutConstraint.activate(sendButtonConstraints) 

    // ➡️ Anexo do Evento de Clique:
    // self: O objeto (target) que irá executar o método (neste caso, a própria ViewController)
    // action: O método a ser chamado, referenciado por #selector
    // for: O evento que irá disparar o método (toque completo e soltura dentro dos limites do botão)
    sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
}
```

#### B. Implementação do Método de Ação

O método que será executado pelo botão deve ser definido com o prefixo **`@objc`** para ser acessível pelo runtime do Objective-C (necessário para o `#selector`). Adotamos a nomenclatura recomendada **`didTapSendButton`** para clareza.

```swift
// Implementação do Método de Ação
@objc func didTapSendButton() {
    // 💡 Lógica de Sign-In será implementada aqui.
    // Exemplo: Recuperar o texto dos campos
    let email = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    
    print("Email: \(email)")
    print("Password: \(password)")
    
    // Futuramente: Chamar a API de autenticação e navegar para outra tela.
}
```

-----

#### A. Criação dos Elementos de UI (Adicionando o Botão com `lazy var`)

Os elementos são declarados como **`lazy var`** para que a inicialização ocorra **somente no primeiro acesso**, e agora o **`sendButton`** inclui o **`addTarget`** em sua própria definição.

| Tipo | Uso |
| :--- | :--- |
| **`lazy var`** | A inicialização (o bloco `{ ... }`) só roda quando a variável é acessada pela primeira vez. Isso é comum para elementos de UI que precisam de acesso a `self` (como o `addTarget`). |

```swift
// Elementos de Texto (emailTextField e passwordTextField) ...

lazy var sendButton: UIButton = {
    let button = UIButton()
    button.setTitle("send", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .black
    // ESSENCIAL para usar constraints
    button.translatesAutoresizingMaskIntoConstraints = false
    
    // ➡️ Anexo do Evento de Clique (dentro do 'lazy var'):
    // self: A própria ViewController é o alvo do método.
    // action: Referencia o método que será implementado abaixo.
    // for: O evento que dispara a ação (toque dentro dos limites do botão).
    button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    
    return button
}()
```

#### B. Implementação do Método de Ação

O método que será chamado pelo botão precisa ser implementado na classe com o prefixo **`@objc`**:

```swift
@objc func didTapSendButton() {
    // Lógica de Sign-In / Autenticação será executada aqui.
    print("Botão 'Send' foi tocado. Iniciando autenticação...")
}
```

#### C. Configuração em `viewDidLoad()`

O código em `viewDidLoad()` agora fica mais limpo, pois não é mais necessário chamar o `addTarget` separadamente, apenas adicionar o botão à view e ativar as *constraints*.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.orange
    
    // Adicionamos os elementos à view
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(sendButton) // O evento já foi configurado acima!

    // ... Ativação das Constraints (inalterada) ...
    
    // Ativa todas as regras
    NSLayoutConstraint.activate(emailConstraints)
    NSLayoutConstraint.activate(passwordConstraints)
    NSLayoutConstraint.activate(sendButtonConstraints) 
}
```

## VIEW / VIEW MODEL / MODEL 