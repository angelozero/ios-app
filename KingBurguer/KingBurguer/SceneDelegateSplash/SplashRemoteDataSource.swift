//
//  SplashRemoteDataSource.swift
//  KingBurguer
//
//  Created by angelo on 17/11/25.
//

import Foundation

class SplashRemoteDataSource {
    static let shared = SplashRemoteDataSource()
    
    func refreshToken(request: RefreshTokenRequest, accessToken: String,  completion: @escaping (SignInResponse?, Bool) -> Void){
        WebServiceAPI.shared.call(path: .refreshToken, httpRequestType: .PUT, accessToken: accessToken, data: request) { result in
            switch result {
                
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, false)
                break
                
            case .failure(let error, let data):
                print("ERROR LOGIN \(error)")
                completion(nil, true)
                break
            }
        }
    }
}
