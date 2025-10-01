//
//  SceneDelegate.swift
//  KingBurguer
//
//  Created by angelo on 26/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Tenta converter a cena (scene) para UIWindowScene; se falhar, sai do método.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Cria uma nova janela (UIWindow) que cobre toda a área da tela da cena.
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        // Define a tela (ViewController) que será mostrada primeiro na janela injetando SignInViewModel como dependencia.
        window?.rootViewController = SignInViewController(signInViewModel: SignInViewModel())
        
        // Associa esta nova janela à cena de janela (windowScene) que acabamos de obter.
        window?.windowScene = windowScene

        // Torna a janela a principal e a visível na tela.
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
  
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
     
    }

}

