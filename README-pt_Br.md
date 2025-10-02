1.  **Fundamentos do Projeto:** Ciclo de Vida (`AppDelegate`, `SceneDelegate`).
2.  **Visual:** Gerenciamento de Recursos (`Assets`, `Storyboards`).
3.  **Desenvolvimento de Tela:** Ciclo de Vida da `ViewController` e Construção da UI (`Auto Layout`).
4.  **Arquitetura:** Introdução ao **MVVM** e ao padrão de **Reatividade de Estado**.

-----

# 🚀 Meu Primeiro App iOS: Da Estrutura à Arquitetura Reativa

Este documento registra a evolução do projeto, cobrindo desde os fundamentos do ciclo de vida da aplicação iOS até a implementação de um padrão arquitetural reativo (MVVM).

-----

## I. Fundamentos e Ciclo de Vida da Aplicação

### 1\. Classes de Ciclo de Vida (`AppDelegate` e `SceneDelegate`)

O iOS separa a gestão do aplicativo em duas classes principais, especialmente a partir do iOS 13, para suportar multi-janelas (Cenas).

#### 1.1. `AppDelegate` (Ciclo de Vida do Processo)

É a classe principal do aplicativo, responsável por gerenciar o ciclo de vida do **processo** como um todo, interagindo com o **UIKit**.

  * **Protocolos:** Implementa `UIResponder` e `UIApplicationDelegate`.
  * **Anotação:** `@main` marca o ponto de entrada principal do aplicativo.
  * **Método Chave:**
      * `application(_:didFinishLaunchingWithOptions:)`: O primeiro método a ser chamado. Ideal para inicialização de bibliotecas de terceiros ou configuração global.

#### 1.2. `SceneDelegate` (Ciclo de Vida da Janela/Cena)

É responsável por gerenciar o ciclo de vida de uma **cena** (janela) individual.

  * **Protocolo:** Implementa `UIWindowSceneDelegate`.

  * **Método Chave (`scene(_:willConnectTo:options:)`):**
    Este é o ponto onde a **UI é configurada**. É aqui que criamos a `UIWindow` e definimos a **`rootViewController`** (a primeira tela a ser exibida).

    ```swift
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 1. Cria a UIWindow
        let window = UIWindow(windowScene: windowScene)
        // 2. Define a tela inicial (ex: SignInViewController)
        window.rootViewController = SignInViewController() 
        // 3. Exibe
        self.window = window
        window.makeKeyAndVisible()
    }
    ```

-----

## II. Recursos Visuais e Estrutura de UI

### 2\. Gerenciamento de Recursos (`Assets` e `Storyboards`)

#### 2.1. O que é a Pasta `Assets.xcassets`?

É o catálogo central para gerenciamento de recursos visuais do aplicativo (imagens, ícones e cores).

  * **Finalidade:** Gerencia automaticamente múltiplas resoluções (`@2x`, `@3x`), otimiza o empacotamento do app e facilita a configuração de **`Dark Mode`**.

#### 2.2. O que é o `Main.storyboard`?

É um arquivo **XML** que descreve o fluxo visual (telas e transições) e o layout das telas usando o editor gráfico do Xcode.

  * **Componentes:** `View Controllers` (telas), `Views` (elementos de UI), `Segues` (transições) e `Auto Layout` (restrições de layout).

-----

## III. Desenvolvimento de Tela (`ViewController`)

### 3\. A `ViewController` e seu Ciclo de Vida

A `ViewController` é a classe principal que gerencia o ciclo de vida de uma tela, atuando como intermediária entre a UI (`View`) e a lógica de dados (`Model`/`ViewModel`).

#### 3.1. Métodos Essenciais (`UIViewController`):

| Método | Execução | Uso Típico |
| :--- | :--- | :--- |
| **`viewDidLoad()`** | **Uma única vez**, após a View ser carregada na memória. | **Configurações iniciais**: Adicionar subviews, configurar `Auto Layout` e fazer a primeira requisição de dados. |
| `viewWillAppear(_:)` | **Toda vez**, pouco antes da View aparecer. | Recarregar dados que podem ter sido alterados em outra tela. |
| `viewDidDisappear(_:)` | **Toda vez**, após a View ser totalmente removida. | Pausar tarefas, parar animações. |

### 4\. Implementação da UI (`SignInViewController`)

A UI da tela de login foi construída inteiramente por código, utilizando `Auto Layout` via **`NSLayoutConstraint`**.

#### 4.1. `Auto Layout` e Âncoras

As **`Constraints`** definem o posicionamento e o tamanho dos elementos de UI de forma adaptável, usando as **Âncoras** para definir relações de posição (ex: `leadingAnchor`, `topAnchor`) e tamanho.

| Âncora | Significado | Âncora | Significado |
| :--- | :--- | :--- | :--- |
| `leadingAnchor` | Esquerda | `trailingAnchor` | Direita |
| `centerYAnchor` | Centro Vertical | `centerXAnchor` | Centro Horizontal |

#### 4.2. `lazy var` e Ação do Botão

O botão (`sendButton`) é declarado como **`lazy var`**. Isso garante que sua inicialização e a configuração de seu evento (`addTarget`) ocorram de forma segura e eficiente **somente no primeiro acesso**.

```swift
lazy var sendButton: UIButton = {
    // ... configurações de UI ...
    // Adiciona a ação (método didTapSendButton) ao evento de toque.
    button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    return button
}()

// O método que precisa ser chamado pelo sistema deve usar @objc.
@objc func didTapSendButton() {
    // ➡️ Aqui é onde chamamos a lógica da ViewModel.
    // print("Botão 'Send' foi tocado...")
}
```

-----

## IV. Arquitetura e Reatividade (MVVM)

A arquitetura foi evoluída para o padrão **Model-View-ViewModel (MVVM)**, utilizando um mecanismo de **Reatividade de Estado** para comunicação.

### 5\. Injeção de Dependência e `weak delegate`

#### 5.1. Injeção de Dependência

A `ViewModel` é injetada no construtor (`init`) do `ViewController`. Essa é a **melhor prática** para garantir que a `ViewController` tenha tudo o que precisa para funcionar (dependência obrigatória).

```swift
init(signInViewModel: SignInViewModel) {
    self.signInViewModel = signInViewModel
    super.init(nibName: nil, bundle: nil) 
    // Configuração do delegate só pode ser feita após super.init
    self.signInViewModel.delegate = self 
}
```

#### 5.2. `weak delegate` (Quebrando Ciclo de Retenção)

Para evitar **Vazamentos de Memória (Retain Cycles)**, a referência ao `delegate` (o Controller) na `ViewModel` é sempre declarada como **`weak`**.

```swift
// Em SignInViewModel.swift
weak var delegate: SigninViewModelDelegate? 
```

### 6\. Padrão de Comunicação por Estado

O **Estado** (`SignInState`) e o `didSet` são usados para criar um mecanismo de Observador-Observado simples e claro.

#### 6.1. Definição do Estado

O `enum` **`SignInState`** encapsula todos os possíveis resultados da lógica de negócio.

```swift
enum SignInState {
    case none
    case loading        // Operação em andamento
    case success
    case error(errorMessage: String) // Falha com mensagem detalhada
}
```

#### 6.2. Reatividade da `ViewModel`

O bloco `didSet` na propriedade `state` garante que, toda vez que o estado muda, o `delegate` (Controller) é notificado automaticamente com o novo estado.

```swift
// Em SignInViewModel.swift
var state: SignInState = .none {
    didSet {
        // Notifica o Controller sempre que o valor é alterado
        delegate?.viewModelDidChanged(state: state)
    }
}
```

Claro\! É ótimo ver o seu `SignInViewController` evoluindo para lidar de forma concreta com os diferentes estados reativos, especialmente a exibição de alertas para erros.

Vou atualizar a seção **3.2. Consumo do Estado** e a seção **6.3. Consumo no `ViewController`** do seu `README` para refletir a nova lógica de tratamento de estado, incluindo a exibição de um `UIAlertController` e o método auxiliar `printState`.

-----

### 6.3. Consumo no `ViewController`

O Controller implementa o protocolo `SigninViewModelDelegate` e reage a cada estado. Esta lógica agora inclui a exibição de um `UIAlertController` nativo do iOS para o estado de erro, garantindo feedback imediato ao usuário.

```swift
// Observador do ViewModel
extension SignInViewController: SigninViewModelDelegate {
    func viewModelDidChanged(state: SignInState){
        
        switch state {
            
        case .none:
            printState(state: .none)
            
        case .loading:
            // Lógica futura: Mostrar um spinner de loading.
            printState(state: .loading)
            
        case .success:
            // Lógica futura: Navegar para a próxima tela.
            printState(state: .success)
            
        case .error(let errorMessage):
            // 🎯 Tratamento de Erro: Exibe um alerta com a mensagem do estado.
            let alert = UIAlertController(title: "Error", 
                                          message: errorMessage, 
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            // Apresenta o alerta na tela
            self.present(alert, animated: true)
            
        }
    }
    
    // Método auxiliar para fins de debug e observação do estado
    func printState(state: SignInState){
        print("Status: \(state)")
    }
}
```

### 🎯 Ponto-Chave

O **Tratamento de Erros** é feito de forma declarativa: A **`ViewModel`** apenas define *qual* é o erro (`.error(errorMessage: "...")`), e a **`ViewController`** decide *como* apresentar esse erro (neste caso, com um `UIAlertController`), mantendo a **Separação de Responsabilidades**. O método `present(_:animated:)` do `UIViewController` é usado para exibir o alerta de forma modal.