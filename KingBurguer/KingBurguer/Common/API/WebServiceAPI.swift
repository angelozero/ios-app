//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

import Foundation

class WebServiceAPI {
    
    /**
     * URL: https://hades.tiagoaguiar.co/hades/users/kingburguer/apikey?email=angelo.akm@gmail.com
     * RESPONSE POST ---> {"id":247,"name":"Test","email":"test@test.com", "password": "123456", "document":"93122232081","birthday":"2000-01-01"}
     * JSON para STRING --> let userRequestString = JSONConverter().convertDataToString(data: userRequestJson!)
     */
    
    struct DataDetail: Decodable {
        let detail: String?
    }
    
    
    // SINGLETON pattern
    static let shared = WebServiceAPI()
    private static let API_KEY = "af13bbda-2c03-4bde-899b-317aacf7a21a"
    private static let URL_SERVICE = "https://hades.tiagoaguiar.co/kingburguer"
    
    func createUser(data: UserRequest?, completion: @escaping (Result<Void, Error>) -> Void){
        return call (path: .createUser, httpRequestType: .POST, data: data, completion: completion)
    }
    
    private func call(path: EndpointEnum, httpRequestType: HttpRequestTypeEnum, data: Encodable?, completion: @escaping (Result<Void, Error>) -> Void){
        guard let request = generateRequest(path: path, httpRequestType: httpRequestType, data: data) else { return }
        
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
                    completion(.failure(APIError.errorData(message: "No data found")))
                    return
                }
                                
                do {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(DataDetail.self, from: data)
                                        
                    if response.detail == nil || response.detail == "" {
                        print("Success WEB-SERVICE-API")
                        if let responseValue = String(data: data, encoding: .utf8) {
                            print(responseValue)
                        }
                        completion(.success(()))
                        
                    } else {
                        // Retorno JSON diferente do esperado (mensagem de sucesso diferente)
                        completion(.failure(APIError.errorData(message: response.detail ?? "Sem info" )))
                    }
                    
                } catch {
                    print("Falha ao decodificar a resposta como sucesso esperado.")
                    if let responseValue = String(data: data, encoding: .utf8) {
                        print("Retorno Bruto: \(responseValue)")
                    }
                    
                    completion(.failure(APIError.errorData(message: "Erro ao recuperar info da requisição")))
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
