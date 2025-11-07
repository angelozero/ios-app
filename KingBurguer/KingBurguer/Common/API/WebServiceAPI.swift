//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

import Foundation

class WebServiceAPI {
    
    // https://hades.tiagoaguiar.co/hades/users/kingburguer/apikey?email=angelo.akm@gmail.com
    private static let API_KEY = "af13bbda-2c03-4bde-899b-317aacf7a21a"
    private static let CPF = "93122232081"
    
    // {"id":247,"name":"Test","email":"test@test.com", "password": "123456", "document":"93122232081","birthday":"2000-01-01"}
    
    // SINGLETON pattern
    static let shared = WebServiceAPI()
    
    func createUser(userRequest: UserRequest, completion: @escaping (Result<Void, Error>) -> Void){
        let endpoint = "https://hades.tiagoaguiar.co/kingburguer/users"
        
        let userRequestJson = JSONConverter().encode(encodable: userRequest)
        //let userRequestString = JSONConverter().convertDataToString(data: userRequestJson!)
        
        guard let url = URL(string: endpoint) else {
            print("URL Error!!!")
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(WebServiceAPI.API_KEY, forHTTPHeaderField: "x-secret-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpBody = userRequestJson
        
        // essa chamada é executada assincronamente
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro WEB-SERVICE-API")
                    print(error)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    print("NO DATA FOUND")
                    completion(.failure(APIError.noData))
                    return
                }
                
                print("Success WEB-SERVICE-API")
                if let responseValue = String(data: data, encoding: .utf8) {
                    print(responseValue)
                }
                
                completion(.success(()))
            }
        }
        
        task.resume()
    }
}
