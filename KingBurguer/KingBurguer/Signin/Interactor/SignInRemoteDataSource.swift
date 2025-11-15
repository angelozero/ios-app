//
//  SignInRemoteDataSource.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation

class SignInRemoteDataSource {
    static let shared = SignInRemoteDataSource()
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void){
        WebServiceAPI.shared.call(path: .login, httpRequestType: .POST, data: request) { result in
            switch result {
                
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                print("ERROR LOGIN \(error)")
                guard let data = data else { return }
                switch error {
                
                case .unauthorized:
                    let response = try? JSONDecoder().decode(SignInResponseNotAuthorized.self, from: data)
                    print(response?.detail ?? "Unauthorized")
                    completion(nil, response?.detail.message ?? "Unauthorized")
                    break
                
                default:
                    let response = try? JSONDecoder().decode(SignInResponseErro.self, from: data)
                    print(response?.detail ?? "Unknown Login Error")
                    completion(nil, response?.detail ?? "Unknown Login Error")
                    break
                }
                break
            }
        }
    }
}
