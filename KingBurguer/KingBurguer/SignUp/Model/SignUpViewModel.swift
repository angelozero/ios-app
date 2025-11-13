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
        //        simulando delay de 2 segs
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
        //            self.state = .success
        //        }
        
        // MELHOR PRÁTICA: Desembrulha todos os optionals necessários de forma segura e antecipada
        guard let name = signUpUserModel.name,
              let password = signUpUserModel.password,
              let email = signUpUserModel.email,
              let document = signUpUserModel.document,
              let birthday = signUpUserModel.birthday else {
            
            // Se qualquer um for nil, define um estado de erro e retorna (Early Exit)
            print("Erro de validação: Dados do usuário incompletos.")
            self.state = .error(errorMessage: "Dados incompletos para envio.")
            return
        }
        
        var userRequest = UserRequest(name: name,
                                      password: password,
                                      email: email,
                                      document: document.removeCPFSpecialCharacters(),
                                      birthday: birthday.reformatDateToISO8601())
        
        /**
         O que este trecho faz ?
         - Quando esta chamada de API terminar, execute este bloco de código, capturando o objeto self de forma fraca (para evitar memory leaks).
         - O resultado da chamada estará disponível na variável result."
         */
        
        // '[weak self]'---> Isso é chamado de Capture List.
        // Ele diz ao Swift para capturar a referência ao self de forma fraca (weak), em vez de forte.
        // Use [weak self] para evitar retenção de ciclo
        var response = WebServiceAPI.shared.createUser(data: userRequest)
        
        print(response)
        self.state = .error(errorMessage: "Teste")
//        if response != nil {
//            self.state = .success
//            
//        } else {
//            self.state = .error(errorMessage: <#T##String#>)
//        }
    }
    
    func goToHome(){
        signUpcoordinator?.goToHome()
    }
}
