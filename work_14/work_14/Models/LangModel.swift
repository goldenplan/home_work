//
//  LangModel.swift
//  work_2
//
//  Created by Stanislav Belsky on 15.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct LangModel: Decodable {
    
    let data: [LangData]
}

struct LangData: Decodable, Identifiable, Equatable {
    var id: String {
        return code
    }
    
    let code: String
    let name: String
}
