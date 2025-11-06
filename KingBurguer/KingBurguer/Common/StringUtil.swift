//
//  StringUtil.swift
//  KingBurguer
//
//  Created by angelo on 30/10/25.
//

import UIKit

enum DateFormattingError: Error {
    case invalidInputFormat
}

extension String {
    // Expressão Regular para email no formato aaa@bbb.com
    var isInvalidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    // Expressão Regular para CPF no formato 000.111.222-33
    var isIvalidCPFFormat: Bool {
        let cpfRegex = "^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$"
        return NSPredicate(format: "SELF MATCHES %@", cpfRegex).evaluate(with: self)
    }
    
    // Expressão Regular para Data de Nascimento no formato DD/MM/YYYY
    var isValidBirthDateFormat: Bool {
        guard self.count == 10 else {
            return false
        }
        
        // 2. Define o formatador de data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        // **ESSENCIAL**: Impede que o DateFormatter "corrija" datas inválidas
        dateFormatter.isLenient = false
        
        // 3. Tenta converter a string para uma Data
        guard let date = dateFormatter.date(from: self) else {
            // Falha se o formato não for DD/MM/YYYY ou se for uma data inválida (ex: 31/02/2025)
            return false
        }
        
        // 4. Validação Adicional (Ex: Verificar se a data não é futura)
        // Se a data for futura, é inválida para um aniversário.
        return date <= Date()
    }
    
    func reformatDateToISO8601() throws -> String {
            
            let formatterEntrada = DateFormatter()
            formatterEntrada.dateFormat = "dd/MM/yyyy"
            formatterEntrada.locale = Locale(identifier: "en_US_POSIX")
            formatterEntrada.isLenient = false

            // Tenta converter a string de entrada para um objeto Date
            guard let dataObjeto = formatterEntrada.date(from: self) else {
                // Se falhar, lança o erro
                throw DateFormattingError.invalidInputFormat
            }
            
            let formatterSaida = DateFormatter()
            formatterSaida.dateFormat = "yyyy-MM-dd"
            formatterSaida.locale = Locale(identifier: "en_US_POSIX")

            // Retorna a string formatada (sem ser opcional)
            return formatterSaida.string(from: dataObjeto)
        }
    
    func charAtIndex(index: Int) -> Character? {
        var indexCurrent = 0
        // self é a propria string que chamou esse método
        for char in self {
            if index == indexCurrent {
                return char
            }
            indexCurrent = indexCurrent + 1
        }
        return nil
    }
}
