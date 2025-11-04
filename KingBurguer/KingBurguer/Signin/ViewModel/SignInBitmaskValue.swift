//
//  SignInBitmaskValue.swift
//  KingBurguer
//
//  Created by angelo on 03/11/25.
//

import Foundation

class SignInBitmaskValue: BaseBitmaskProtocol {
    
    var bitmaskValue: SignInBitmaskValueEnum
    
    init(_ bitmaskValue: SignInBitmaskValueEnum) {
        self.bitmaskValue = bitmaskValue
    }
    
    func getBitmaskValue() -> Int {
        self.bitmaskValue.rawValue
    }
}
