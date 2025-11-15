//
//  SignInInteractor.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation


class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void){
        remote.login(request: request) { signInResponse, error in
            
            guard let response = signInResponse else { return }
            
            let userAuth = UserAuth(accessToken: response.accessToken,
                                    refreshToken: response.refreshToken,
                                    expiresSeconds: response.expiresSeconds,
                                    tokenType: response.tokenType)
            
            
            self.local.insertUserAuth(userAuth: userAuth)
            
            completion(signInResponse, error)
        }
    }
}
