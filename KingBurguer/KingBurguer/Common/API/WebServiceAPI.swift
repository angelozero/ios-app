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
 *
 * 𝐂𝐚𝐫𝐨𝐮𝐬𝐞𝐥 𝐏𝐚𝐫𝐚𝐥𝐥𝐚𝐱 𝐄𝐟𝐟𝐞𝐜𝐭 swift
 * https://www.youtube.com/watch?v=ZObqzVCHPeE
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
    
    static let shared = WebServiceAPI()
    private static let API_KEY = "af13bbda-2c03-4bde-899b-317aacf7a21a"
    private static let URL_SERVICE = "https://hades.tiagoaguiar.co/kingburguer"
    
    // @escaping ---> é um callback, é um bloco assincrono que sera executado
    func call <T: Encodable>(path: EndpointEnum, httpRequestType: HttpRequestTypeEnum, accessToken: String? = nil, data: T? = Data(), completion: @escaping (Result) -> Void){
        guard let request = generateRequest(path: path, httpRequestType: httpRequestType, accessToken: accessToken, data: data) else { return }
        
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

    private func generateRequest(path: EndpointEnum, httpRequestType: HttpRequestTypeEnum, accessToken: String? = nil, data: Encodable?) -> URLRequest? {
        guard let url = URL(string: WebServiceAPI.URL_SERVICE + path.rawValue) else {
            print("URL Error!!!")
            return nil
        }
        
        var request =  URLRequest(url: url)
        request.setValue(WebServiceAPI.API_KEY, forHTTPHeaderField: "x-secret-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        if let accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField:  "Authorization")
        }
        
        request.httpMethod = httpRequestType.rawValue
        
        if httpRequestType != .GET && httpRequestType != .DELETE {
            if let dataJson = data {
                request.httpBody = JSONConverter().encode(encodable: dataJson)
            }
        }
        
        return request
    }
}
