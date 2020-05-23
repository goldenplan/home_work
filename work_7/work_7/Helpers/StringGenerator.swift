//
//  StringGenerator.swift
//  work_7
//
//  Created by Stanislav Belsky on 5/23/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

open class StringGenerator {
  fileprivate let alphanumericCharacterString: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  
  open func generateRandomString(_ length: Int) -> String {
    var randomString = String()
    for _ in 0 ..< length {
        let elements = UInt32(alphanumericCharacterString.count)
        let randomIndex = Int(arc4random_uniform(elements))
        randomString += String(Array(alphanumericCharacterString)[randomIndex])
    }

    return randomString
  }
  
  open func standardRandomString() -> String {
    return generateRandomString(12)
  }
  
  open func randomSingleCharacterString() -> String {
    return generateRandomString(1)
  }
}
