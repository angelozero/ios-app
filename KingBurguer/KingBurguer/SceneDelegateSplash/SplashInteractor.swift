//
//  SceneDelegateInteractor.swift
//  KingBurguer
//
//  Created by angelo on 17/11/25.
//

import Foundation

class SplashInteractor {
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func refreshToken(request: RefreshTokenRequest, completion: @escaping (SignInResponse?, Bool) -> Void){
        
        let data = local.getUserAuth()
        
        guard let userAccessToken = data?.accessToken else {
            completion(nil, true)
            return
        }
        
        remote.refreshToken(request: request, accessToken: userAccessToken) { signInResponse, isFail in
            
            guard let response = signInResponse else {
                completion(nil, true)
                return
            }
            
            let userAuth = UserAuth(accessToken: response.accessToken,
                                    refreshToken: response.refreshToken,
                                    expiresSeconds: Int(Date().timeIntervalSince1970 + Double(response.expiresSeconds)),
                                    tokenType: response.tokenType)
            
            
            self.local.insertUserAuth(userAuth: userAuth)
            
            completion(signInResponse, isFail)
        }
    }
}
