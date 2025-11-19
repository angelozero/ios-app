//
//  SceneDelegate.swift
//  KingBurguer
//
//  Created by angelo on 26/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let localDataSource: LocalDataSource = .shared
    var window: UIWindow?
    
    var homeCoordinator: HomeCoordinator!
    private var splashInteractor = SplashInteractor()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        if let userAuth = localDataSource.getUserAuth() {
            userAuthenticated(userAuth: userAuth)
            
        } else {
            userNotAuthenticated()
        }
        
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
    
    private func userAuthenticated(userAuth: UserAuth){
        print("User Authenticated ---> \(userAuth.accessToken)")
        
        if Date().timeIntervalSince1970 > Double(userAuth.expiresSeconds) {
            print("Login token expired")
            let refreshTokenRequest = RefreshTokenRequest(refreshToken: userAuth.refreshToken)
            DispatchQueue.main.async {
                self.splashInteractor.refreshToken(request: refreshTokenRequest) { response, isFail in
                    if isFail {
                        let signInCoordinator = SignInCoordinator(window: self.window)
                        signInCoordinator.start()
                        
                    } else {
                        self.homeCoordinator = HomeCoordinator(window: self.window)
                        self.homeCoordinator.start()
                    }
                }
            }
        } else {
            let signInCoordinator = SignInCoordinator(window: self.window)
            signInCoordinator.start()
        }
    }
    
    private func userNotAuthenticated(){
        print("User not authenticated")
        let signInCoordinator = SignInCoordinator(window: window)
        signInCoordinator.start()
    }
    
}

