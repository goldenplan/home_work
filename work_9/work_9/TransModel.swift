//
//  TransModel.swift
//  work_9
//
//  Created by Stanislav Belsky on 5/12/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class TransModel {
    
    static let instance = TransModel()
    
    func pineapplesCountUniversal(count: Int) -> String{
            
            let formatString : String = NSLocalizedString(
                "apples count",
                comment: "No count string format to be found in Localized.stringsdict")
            let resultString : String = String.localizedStringWithFormat(formatString, count)
            return resultString;
    }
    
}
