//
//  StringUtil.swift
//  KingBurguer
//
//  Created by angelo on 30/10/25.
//

import UIKit

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
