//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation

class SignUpViewModel {
   
    weak var signUpViewModelDelegate: SignUpViewModelDelegate?
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
        
        var userRequest = UserRequest(name: "Test", password: "123456", email: "test@test.com", document: "93122232081", birthday: getDate("01/01/2000"))
        WebServiceAPI.shared.createUser(userRequest: userRequest)
    }
   
    func registerUser(){
        print("User saved")
    }
    
    func goToHome(){
        signUpcoordinator?.goToHome()
    }
    
    private func getDate(_ date: String) -> String{
        do {
            return try date.reformatDateToISO8601()
        } catch {
            return "2000-01-01"
        }
    }
}
