//
//  SignUpRemoteDataSource.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation

class SignUpRemoteDataSource {
    
    static let shared = SignUpRemoteDataSource()

    
    func createUser(data: UserRequest, completion: @escaping (Bool?, String?) -> Void)  {
        WebServiceAPI.shared.call (path: .createUser, httpRequestType: .POST, data: data) { result in
            
            switch result {
                
            case .success(let data):
                if let dataValue = data {
                    print("SUCESS: \(String(describing: String(data: dataValue, encoding: .utf8)))")
                    let response = try? JSONDecoder().decode(UserResponse.self, from: dataValue)
                    print("RESPONSE ---> \(String(describing: response))")
                    completion(true, nil)
                    break
                }
                break
                
            case .failure(let error, let data):
                guard let dataValue = data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(SignUpResponseNotAuthorized.self, from: dataValue)
                    print(response?.detail ?? "Unauthorized")
                    completion(false, response?.detail.message ?? "Unauthorized")
                    break
                case .badRequest:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: dataValue)
                    print(response?.detail ?? "Bad Request")
                    completion(false, response?.detail ?? "Bad Request")
                    break
                    
                case .notFound:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: dataValue)
                    print(response?.detail ?? "Not Found")
                    completion(false, response?.detail ?? "Not Found")
                    break
                    
                default:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: dataValue)
                    print(response?.detail ?? "Unknown Error")
                    completion(false, response?.detail ?? "Unknown Error")
                    break
                }
                
                break
            }
        }
    }
    
}
