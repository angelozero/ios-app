//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation

class SignUpViewModel {
    
    weak var signUpViewModelDelegate: SignUpViewModelDelegate?
    
    var signUpUserModel = SignUpUserModel()
    
    var signUpcoordinator: SignUpCoordinator?
    
    var state: SignUpState = .none {
        didSet {
            signUpViewModelDelegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send(){
        state =  .loading
        
        guard let name = signUpUserModel.name,
              let password = signUpUserModel.password,
              let email = signUpUserModel.email,
              let document = signUpUserModel.document,
              let birthday = signUpUserModel.birthday else {
            
            self.state = .error(errorMessage: "Dados incompletos para envio.")
            return
        }
        
        let userRequest = UserRequest(name: name,
                                      password: password,
                                      email: email,
                                      document: document.removeCPFSpecialCharacters(),
                                      birthday: birthday.reformatDateToISO8601())
        
        
        WebServiceAPI.shared.createUser(data: userRequest) { created, error in
            
            DispatchQueue.main.async {
                if let errorMessage = error {
                    self.state = .error(errorMessage: errorMessage)
                    
                } else if let createdData = created {
                    if createdData {
                        self.state = .success
                    }
                }
            }
        }
    }
    
    func goToHome(){
        signUpcoordinator?.goToHome()
    }
    
    func goToLogin() {
        signUpcoordinator?.goToLogin()
    }
}
