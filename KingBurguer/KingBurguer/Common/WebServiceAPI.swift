//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

import Foundation

class WebServiceAPI {
    
    // SINGLETON pattern
    static let shared = WebServiceAPI()
    
    func createUser(){
        let endpoint = "https://hades.tiagoaguiar.co/kingburguer"
        
        guard let url = URL(string: endpoint) else {
            print("URL Error!!!")
            return
        }
        
        let request = URLRequest(url: url)
        
        
        // essa chamada é executada assincronamente
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response ---> \(String(describing: response))")
            print("")
            
            if let error = error {
                print("Erro WEB-SERVICE-API")
                print(error)
                return
            }
            
            guard let data = data else {
                print("NO DATA FOUND")
                return
            }
            
            print("Success WEB-SERVICE-API")
            if let responseValue = String(data: data, encoding: .utf8) {
                print(responseValue)
                
            }
        }
        
        task.resume()
    }
}
