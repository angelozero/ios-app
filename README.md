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


## V. Navegação e Gestão de Fluxo (`UINavigationController`)

O aplicativo foi configurado para usar o **`UINavigationController`**, que gerencia uma pilha de *View Controllers* e fornece a barra de navegação padrão (título e botão "Voltar").

### 1\. Configuração no `SceneDelegate`

Para iniciar a navegação, a `SignInViewController` é definida como a **tela raiz** (`rootViewController`) de uma nova instância do `UINavigationController`. O *Controller de Navegação* então se torna o `rootViewController` principal da janela.

```swift
// Em SceneDelegate.swift

let signInViewModel: SignInViewModel = SignInViewModel()
let signInViewController = SignInViewController(signInViewModel: signInViewModel)

// ➡️ 1. Cria o Controller de Navegação e define a tela de Sign In como a base da pilha.
let navigationViewController = UINavigationController(rootViewController: signInViewController)

// ➡️ 2. O Controller de Navegação é quem controla a janela principal.
window?.rootViewController = navigationViewController
```

### 2\. Navegação em Pilha (`pushViewController`)

O `UINavigationController` utiliza o conceito de **Pilha (Stack)**. Adicionar uma nova tela ao topo da pilha é chamado de **"push"**; remover a tela atual e voltar para a anterior é chamado de **"pop"**.

#### 2.1. Novos Componentes (`SignInViewController`)

A `SignInViewController` foi atualizada com dois botões de ação:

| Componente | Finalidade |
| :--- | :--- |
| `logInButton` | Mantido para a lógica de autenticação. |
| **`registerButton`** | Implementado para navegar para a tela de registro. |

O novo botão (`registerButton`) foi posicionado logo **abaixo** do `logInButton` usando *constraints* para manter o fluxo vertical:

```swift
// Em SignInViewController.swift (Trecho de Constraints)
let registerButtonConstraints = [
    // ...
    // Ancorado abaixo do botão de login, com 10 pontos de espaçamento.
    registerButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10.0),
    // ...
]
```

#### 2.2. Ação de Navegação

O método associado ao `registerButton` usa o `navigationController` (uma propriedade que o `UIViewController` obtém automaticamente quando inserido em uma pilha) para empurrar a nova tela (`SignUpViewController`) para o topo da pilha.

```swift
// Em SignInViewController.swift

@objc func didTapRegisterButton(_ sender: UIButton){
    // Cria a nova tela (o 'destino')
    let signUpViewController = SignUpViewController() 
    
    // ➡️ Executa o Push: Adiciona a nova tela à pilha de navegação.
    // O sistema gerencia a animação e o botão 'Back' automaticamente.
    navigationController?.pushViewController(signUpViewController, animated: true)
}
```

### 3\. A Tela de Destino (`SignUpViewController`)

A `SignUpViewController` é a tela de destino. Ela é uma `UIViewController` simples que será exibida com a barra de navegação completa e o botão "Back" (voltar) funcional, graças ao `UINavigationController`.

```swift
// Em SignUpViewController.swift
class SignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // A cor de fundo é definida como .purple para diferenciação visual.
        view.backgroundColor = .purple 
        // A barra de navegação é herdada e exibida.
    }
}
```

### 🎯 Ponto-Chave

O `UINavigationController` é essencial para gerenciar o fluxo de telas de forma sequencial. Ao usar `pushViewController`, o `UIViewController` de origem **permanece na memória**, mas oculto, permitindo que a tela de destino possa ser removida (`pop`) para retornar ao ponto de partida.

-----

## 7\. Orquestração de Fluxo (Coordinator e Reatividade)

O projeto migrou para o **Padrão Coordinator**, que separa a lógica de navegação dos View Controllers, garantindo que cada classe mantenha uma única responsabilidade.

O fluxo de controle do aplicativo segue a seguinte hierarquia:

### 7.1. Ordem de Inicialização e Controle (De Cima para Baixo)

A inicialização e o controle do fluxo são estabelecidos através de **Injeção de Dependência** e **Referência Forte** no `SceneDelegate`.

| Sequência | Componente | Responsabilidade Principal |
| :--- | :--- | :--- |
| **1.** | `SceneDelegate` | **Ponto de Entrada.** Cria e **armazena** (`var`) o `SignInCoordinator` (referência forte), garantindo sua sobrevivência na memória. |
| **2.** | `SignInCoordinator` | **Diretor de Fluxo.** Cria a `UINavigationController` e o `SignInViewController`. Define o `SignInViewController` como a **raiz** (`rootViewController`) da navegação. |
| **3.** | `UINavigationController` | **Gerenciador de Pilha.** Objeto principal de navegação que hospeda as telas. |
| **4.** | `SignInViewController` | **A View (Interface).** Recebe o `SignInViewModel` no construtor. É responsável apenas por **coletar dados** e **atualizar a UI** com base no `state`. |

### 7.2. Comunicação de Ação (MVVM Reativo)

A comunicação dentro da tela (login ou erro) utiliza o padrão MVVM com Delegate e `didSet`:

1.  **Ação do Usuário:** O usuário clica no `logInButton`. O método `@objc func didTapLogInButton` é chamado.
2.  **Controller Inicia a Lógica:** O `SignInViewController` invoca a ação na sua dependência: `signInViewModel.send()`.
3.  **ViewModel Altera Estado:** O método `send()` na `SignInViewModel` processa a lógica e, em algum momento, **altera** a variável reativa `state` (ex: `self.state = .loading`).
4.  **Callback Automático (`didSet`):** A alteração na variável `state` dispara o *Property Observer* `didSet`, que é o **mecanismo reativo** do Swift.
5.  **Notificação do Delegate:** O `didSet` invoca o método do protocolo: `delegate?.viewModelDidChanged(state: self.state)`.
6.  **View Atualiza UI:** O `SignInViewController` (que implementa `SignInViewModelDelegate`) executa o `viewModelDidChanged(state:)` e atualiza a UI (ex: mostra o alerta de erro ou esconde o spinner).

### 7.3. Ação de Navegação (`didTapRegisterButton`)

Apesar de o código estar atualmente em `SignInViewController`, a navegação respeita o `UINavigationController`:

```swift
// Em SignInViewController.swift
@objc func didTapRegisterButton(_ sender: UIButton){
    let signUpViewController = SignUpViewController()
    // ➡️ O Controller empurra a nova tela para o topo da pilha de navegação.
    navigationController?.pushViewController(signUpViewController, animated: true)
}
```

**Conclusão Arquitetural:**

  * A **`SignInViewModel`** gerencia o **estado** da lógica de autenticação.
  * O **`SignInViewController`** gerencia a **exibição** e é o **observador** desse estado.
  * O **`SignInCoordinator`** gerencia o **fluxo de telas**, decidindo qual tela é a próxima e como ela será apresentada na pilha do **`UINavigationController`**.
  ```shell
    1 - scene delegate
    2 - coordinator
    3 - sign in coordinator 
    4 - navigation controller 
    5 - sign in view controller
        5.1 - tem o metodo didTapRegisterButton que insere em navigation controller o controller signUpviewController
        5.2 - o metodo didTapLogInButton executa o metodo send em signInViewModel 
        5.1 - implementa viewModelDidChanged
    6 - sign in view model 
        6.1 - sign in view tem um parametro chamado state que é alterado toda vez que send é invocado
        6.1 - state tendo seu valor sobrescrito seu método didSet, um callback, sera invocado chamando o metodo viewModelDidChanged do SignInViewModelDelegate
    7 - sign in view controller
        7.0 sign in view controller 'observa' qualquer estimulo da view model
        7.1 - o metodo viewModelDidChanged implementado sera executado
  ```

Essa estrutura garante que a View Controller não precise saber nada sobre os resultados da ViewModel, e o Coordinator não precise saber nada sobre a lógica interna da ViewModel.

Claro, aqui está o item 8 do seu README, explicando a nova implementação e as correções arquiteturais necessárias.

````markdown
## 7\. Orquestração de Fluxo (Coordinator e Reatividade)

O projeto migrou para o **Padrão Coordinator**, que separa a lógica de navegação dos View Controllers, garantindo que cada classe mantenha uma única responsabilidade.

O fluxo de controle do aplicativo segue a seguinte hierarquia:

### 7.1. Ordem de Inicialização e Controle (De Cima para Baixo)

A inicialização e o controle do fluxo são estabelecidos através de **Injeção de Dependência** e **Referência Forte** no `SceneDelegate`.

| Sequência | Componente | Responsabilidade Principal |
| :--- | :--- | :--- |
| **1.** | `SceneDelegate` | **Ponto de Entrada.** Cria e **armazena** (`var`) o `SignInCoordinator` (referência forte), garantindo sua sobrevivência na memória. |
| **2.** | `SignInCoordinator` | **Diretor de Fluxo.** Cria a `UINavigationController` e o `SignInViewController`. Define o `SignInViewController` como a **raiz** (`rootViewController`) da navegação. |
| **3.** | `UINavigationController` | **Gerenciador de Pilha.** Objeto principal de navegação que hospeda as telas. |
| **4.** | `SignInViewController` | **A View (Interface).** Recebe o `SignInViewModel` no construtor. É responsável apenas por **coletar dados** e **atualizar a UI** com base no `state`. |

### 7.2. Comunicação de Ação (MVVM Reativo)

A comunicação dentro da tela (login ou erro) utiliza o padrão MVVM com Delegate e `didSet`:

1.  **Ação do Usuário:** O usuário clica no `logInButton`. O método `@objc func didTapLogInButton` é chamado.
2.  **Controller Inicia a Lógica:** O `SignInViewController` invoca a ação na sua dependência: `signInViewModel.send()`.
3.  **ViewModel Altera Estado:** O método `send()` na `SignInViewModel` processa a lógica e, em algum momento, **altera** a variável reativa `state` (ex: `self.state = .loading`).
4.  **Callback Automático (`didSet`):** A alteração na variável `state` dispara o *Property Observer* `didSet`, que é o **mecanismo reativo** do Swift.
5.  **Notificação do Delegate:** O `didSet` invoca o método do protocolo: `delegate?.viewModelDidChanged(state: self.state)`.
6.  **View Atualiza UI:** O `SignInViewController` (que implementa `SignInViewModelDelegate`) executa o `viewModelDidChanged(state:)` e atualiza a UI (ex: mostra o alerta de erro ou esconde o spinner).

### 7.3. Ação de Navegação (`didTapRegisterButton`)

Apesar de o código estar atualmente em `SignInViewController`, a navegação respeita o `UINavigationController`:

```swift
// Em SignInViewController.swift
@objc func didTapRegisterButton(_ sender: UIButton){
    let signUpViewController = SignUpViewController()
    // ➡️ O Controller empurra a nova tela para o topo da pilha de navegação.
    navigationController?.pushViewController(signUpViewController, animated: true)
}
````

**Conclusão Arquitetural:**

  * A **`SignInViewModel`** gerencia o **estado** da lógica de autenticação.
  * O **`SignInViewController`** gerencia a **exibição** e é o **observador** desse estado.
  * O **`SignInCoordinator`** gerencia o **fluxo de telas**, decidindo qual tela é a próxima e como ela será apresentada na pilha do **`UINavigationController`**.

<!-- end list -->

```shell
  1 - scene delegate
  2 - coordinator
  3 - sign in coordinator 
  4 - navigation controller 
  5 - sign in view controller
      5.1 - tem o metodo didTapRegisterButton que insere em navigation controller o controller signUpviewController
      5.2 - o metodo didTapLogInButton executa o metodo send em signInViewModel 
      5.1 - implementa viewModelDidChanged
  6 - sign in view model 
      6.1 - sign in view tem um parametro chamado state que é alterado toda vez que send é invocado
      6.1 - state tendo seu valor sobrescrito seu método didSet, um callback, sera invocado chamando o metodo viewModelDidChanged do SignInViewModelDelegate
  7 - sign in view controller
      7.0 sign in view controller 'observa' qualquer estimulo da view model
      7.1 - o metodo viewModelDidChanged implementado sera executado
```

Essa estrutura garante que a View Controller não precise saber nada sobre os resultados da ViewModel, e o Coordinator não precise saber nada sobre a lógica interna da ViewModel.

-----

## 8\. Refatoração da Navegação (Fluxo Reversível e Memória)

A necessidade de delegar a navegação de volta para a Home a partir do fluxo de Cadastro (`SignUp`) exigiu a criação de uma **referência parental** no `SignUpCoordinator`. Isso garante que as decisões de fluxo tomadas no fluxo "filho" possam ser repassadas ao fluxo "pai".

### 8.1. Injeção Explícita de Dependência (Corrigindo Referência Nula)

A solução para garantir que o `parentCoordinator` não seja `nil` no momento da navegação foi a **Injeção de Dependência via Construtor**.

| Antes | Depois (Correto) |
| :--- | :--- |
| `parentCoordinator` era opcional e atribuído separadamente após a inicialização. | O `parentCoordinator` é uma dependência obrigatória passada no `init()`. |

**No `SignInCoordinator.swift` (O Pai):**

```swift
func goToSignUp(){
    // ➡️ O Pai (self) injeta sua própria referência diretamente no construtor do Filho.
    signUpcoordinator = SignUpCoordinator(
        window: window, 
        navigationController: self.navigationController, 
        parentCoordinator: self 
    )
    signUpcoordinator?.start()
}
```

Essa mudança estabelece a comunicação clara e **direta** para o caminho de volta: `SignUpViewModel` -\> `SignUpCoordinator` -\> `parentCoordinator.goToHome()`.

### 8.2. Gerenciamento de Memória (O Uso Crucial de `weak var`)

A injeção do `parentCoordinator` via construtor, embora resolva o problema da navegação, cria um **Ciclo de Retenção** (Retain Cycle) que leva a vazamentos de memória (Memory Leaks).

**O problema:**

1.  O `SignInCoordinator` (Pai) tem uma referência **forte** para o `SignUpCoordinator` (Filho) via `var signUpcoordinator`.
2.  O `SignUpCoordinator` (Filho) teria uma referência **forte** para o `SignInCoordinator` (Pai) via `let parentCoordinator`.
3.  Essa referência mútua forte impede que ambos os objetos sejam desalocados da memória, mesmo quando as telas são fechadas.

**A Solução (Referências Fracas):**

Para quebrar o ciclo, a referência do objeto "filho" para o objeto "pai" **DEVE** ser **fraca** (`weak`).

| Classe | Propriedade | Tipo de Referência Aplicada | Motivo |
| :--- | :--- | :--- | :--- |
| `SignUpCoordinator` | `parentCoordinator` | **`weak var`** | Quebra o ciclo de retenção `Pai -> Filho -> Pai`. |
| `SignUpViewModel` | `signUpcoordinator` | **`weak var`** | Quebra o ciclo de retenção `ViewModel <-> Coordinator`. |


A implementação está correta e segue as melhores práticas do Swift: a **Injeção de Dependência** garante a funcionalidade da navegação reversa, e o uso de **`weak var`** garante a saúde do aplicativo, evitando *memory leaks*.