//
//  SignUpInteractor.swift
//  KingBurguer
//
//  Created by angelo on 14/11/25.
//

import Foundation


class SignUpInteractor {
    
    private let remote: SignUpRemoteDataSource = .shared
    
    func createUser(data: UserRequest, completion: @escaping (Bool?, String?) -> Void){
        remote.createUser(data: data, completion: completion)
    }
}
