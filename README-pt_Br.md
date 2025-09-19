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

