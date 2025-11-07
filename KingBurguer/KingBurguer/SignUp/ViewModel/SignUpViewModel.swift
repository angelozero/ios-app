//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation

class SignUpViewModel {
    
    weak var signUpViewModelDelegate: SignUpViewModelDelegate?
    
    var userData: SignUpUserModel = SignUpUserModel()
    
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
        guard let name = userData.name,
              let password = userData.password,
              let email = userData.email,
              let document = userData.document,
              let birthday = userData.birthday else {
            
            // Se qualquer um for nil, define um estado de erro e retorna (Early Exit)
            print("Erro de validação: Dados do usuário incompletos.")
            self.state = .error(errorMessage: "Dados incompletos para envio.")
            return
        }
        
        var userRequest = UserRequest(name: userData.name!,
                                      password: userData.password!,
                                      email: userData.email!,
                                      document: userData.document!,
                                      birthday: birthday.reformatDateToISO8601())
        
        print(userRequest)
        
        // '[weak self]'---> Isso é chamado de Capture List.
        // Ele diz ao Swift para capturar a referência ao self de forma fraca (weak), em vez de forte.
        // Use [weak self] para evitar retenção de ciclo
        WebServiceAPI.shared.createUser(userRequest: userRequest) { [weak self] result in
            
            // Como self é agora uma referência fraca (e, portanto, opcional/optional),
            // você precisa desembrulhá-lo (unwrap) com segurança.
            // 1. Tenta criar uma nova referência FORTE e temporária chamada 'self'.
            // 2. Se a ViewModel já foi desalocada, o 'self' é nil,
            // então o código para aqui (return). O closure não faz nada,
            // mas o vazamento de memória é evitado.
            guard let self = self else { return }
            
            // O 'result' dentro do closure é esse valor retornado
            // pela API (se foi sucesso ou falha), permitindo que você lide com ele usando o switch.
            switch result {
            case .success:
                // SÓ CHAMA O SUCCESS APÓS A RESPOSTA POSITIVA DA API
                print("Usuário criado com sucesso, definindo estado .success")
                self.state = .success
                
            case .failure(let error):
                // CHAMA UM ESTADO DE FALHA (ou lida com o erro)
                print("Falha ao criar usuário: \(error)")
                self.state = .error(errorMessage: "Falha ao criar usuário: \(error)")
            }
        }
        
        /**
         O que este trecho faz ?
         - Quando esta chamada de API terminar, execute este bloco de código,
         capturando o objeto self de forma fraca (para evitar memory leaks).
         - O resultado da chamada estará disponível na variável result."
         */
    }
    
    func goToHome(){
        signUpcoordinator?.goToHome()
    }
}
