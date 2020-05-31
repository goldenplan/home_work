//
//  AuthApi.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class AuthApi {
    
    static let shared = AuthApi()
    
    func isAuth(complition: (Result<Bool, Error>)->()) {
        
        Util.startSleep()
        
        let data = ConfigData.load()
        complition(Result.success(data.isAuthorized))
        
    }
    
}
