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
    var isInvalidBirthDate: Bool {
        let birthDateRegex = "^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\\d{4}$"
        return NSPredicate(format: "SELF MATCHES %@", birthDateRegex).evaluate(with: self)
    }
}
