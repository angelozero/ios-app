//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

/**
 * URL: https://hades.tiagoaguiar.co/hades/users/kingburguer/apikey?email=angelo.akm@gmail.com
 * RESPONSE POST ---> {"id":247,"name":"Test","email":"test@test.com", "password": "123456", "document":"93122232081","birthday":"2000-01-01"}
 * JSON para STRING --> let userRequestString = JSONConverter().convertDataToString(data: userRequestJson!)
 */

import Foundation

class WebServiceAPI {
    
    enum NetworkError {
        case unauthorized
        case badRequest
        case notFound
        case unknowError
        case internalServerError
    }
    
    enum Result {
        case success(Data?)
        case failure(NetworkError , Data?)
    }
    
    static let shared = WebServiceAPI() // SINGLETON pattern
    private static let API_KEY = "af13bbda-2c03-4bde-899b-317aacf7a21a"
    private static let URL_SERVICE = "https://hades.tiagoaguiar.co/kingburguer"
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void){
        call(path: .login, httpRequestType: .POST, data: request) { result in
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
    
    func createUser(data: UserRequest, completion: @escaping (Bool?, String?) -> Void)  {
        call (path: .createUser, httpRequestType: .POST, data: data) { result in
            
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
    
    // @escaping ---> é um callback, é um bloco assincrono que sera executado
    private func call <T: Encodable>(path: EndpointEnum, httpRequestType: HttpRequestTypeEnum, data: T?, completion: @escaping (Result) -> Void){
        guard let request = generateRequest(path: path, httpRequestType: httpRequestType, data: data) else { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                completion(.failure(.internalServerError, data))
                return
            }
            
            if let responseValue = response as? HTTPURLResponse {
                switch responseValue.statusCode {
                case 200:
                    completion(Result.success(data))
                    break
                    
                case 401:
                    completion(Result.failure(.unauthorized, data))
                    break
                    
                case 404:
                    completion(Result.failure(.notFound, data))
                    break
                    
                case 400:
                    completion(Result.failure(.badRequest, data))
                    break
                    
                case 500:
                    completion(Result.failure(.internalServerError, data))
                    break
                    
                default:
                    completion(Result.failure(.unknowError, data))
                    break
                }
            }
        }
        
        task.resume()
    }
    
    private func generateRequest(path: EndpointEnum, httpRequestType: HttpRequestTypeEnum, data: Encodable?) -> URLRequest? {
        guard let url = URL(string: WebServiceAPI.URL_SERVICE + path.rawValue) else {
            print("URL Error!!!")
            return nil
        }
        
        var request =  URLRequest(url: url)
        request.setValue(WebServiceAPI.API_KEY, forHTTPHeaderField: "x-secret-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        request.httpMethod = httpRequestType.rawValue
        if let dataJson = data {
            request.httpBody = JSONConverter().encode(encodable: dataJson)
        }
        
        return request
    }
}
