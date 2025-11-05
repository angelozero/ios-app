//
//  SignUpBitmaskValue.swift
//  KingBurguer
//
//  Created by angelo on 04/11/25.
//

import Foundation

class SignUpBitmaskValue: BaseBitmaskProtocol {
    
    var bitmaskValue: SignUpBitmaskValueEnum
    
    init(_ bitmaskValue: SignUpBitmaskValueEnum) {
        self.bitmaskValue = bitmaskValue
    }
    
    func getBitmaskValue() -> Int {
        self.bitmaskValue.rawValue
    }
}
