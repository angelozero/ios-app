//
//  SignUpBitmaskEnum.swift
//  KingBurguer
//
//  Created by angelo on 04/11/25.
//

import Foundation

enum SignUpBitmaskValueEnum: Int {
    case none = 0x0
    case name = 0x1
    case email = 0x2
    case password = 0x4
    case cpf = 0x8
    case birthday = 0x10
}
