//
//  JsonConverter.swift
//  KingBurguer
//
//  Created by angelo on 05/11/25.
//

import Foundation

struct JSONConverter {

    /// Converte qualquer objeto Encodable em Data (formato binário JSON).
    /// - Parameter encodable: O objeto a ser codificado.
    /// - Returns: O objeto Data representando o JSON, ou nil se a codificação falhar.
    func encode<T: Encodable>(encodable: T) -> Data? {
        let encoder = JSONEncoder()
        
        // Opcional: Para formatar o JSON de forma legível (útil para debug)
        // encoder.outputFormatting = .prettyPrinted
        
        do {
            // Tenta codificar o objeto genérico T
            let jsonData = try encoder.encode(encodable)
            return jsonData
            
        } catch {
            print("❌ Erro de Codificação: Falha ao converter \(T.self) para JSON. Erro: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Converte Data (JSON binário) para uma String legível.
    /// - Parameter data: O Data a ser convertido.
    /// - Returns: Uma String JSON, ou nil se a conversão falhar.
    func convertDataToString(data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
}
