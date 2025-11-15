//
//  SignInInteractor.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation


class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void){
        remote.login(request: request, completion: completion)
    }
}
