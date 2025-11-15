//
//  SigninViewModel.swift
//  KingBurguer
//
//  Created by angelo on 30/09/25.
//

import Foundation


class SignInViewModel {
    
    weak var signInViewModelDelegate: SignInViewModelDelegate?
    var coordinatorSignIn: SignInCoordinator?
    var signInLoginModel = SignInLoginModel()
    
    var state: SignInState = .none {
        didSet {
            signInViewModelDelegate?.viewModelDidChanged(state: state)
        }
    }
    
    
    private let interactor: SignInInteractor
    
    init(interactor: SignInInteractor){
        self.interactor = interactor
    }
    
    func send(){
        state =  .loading
        
        guard let username = signInLoginModel.username,
              let password = signInLoginModel.password
        else {
            
            self.state = .error(errorMessage: "Dados incompletos para login.")
            return
        }
        
        let signInRequest = SignInRequest(username: username, password: password)
        
        
        interactor.login(request: signInRequest) { data, error in
            
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage: errorMessage)
                    
                } else if let createdData = data {
                    print(data?.accessToken ?? "access+token")
                    self.state = .success
                }
            }
        }
    }
    
    func goToSignUp(){
        coordinatorSignIn?.goToSignUp()
    }
    
    func goToHome(){
        coordinatorSignIn?.goToHome()
    }
    
    func goToInfiniteScrollPage(){
        coordinatorSignIn?.goToInfiniteScrollPage()
    }
}
