//
//  Util.swift
//  MacOS
//
//  Created by Stanislav Belsky on 6/7/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class Util {
    
    static let prefs = UserDefaults.standard
    
    class func setDefaults(){
        print("setDefaults")
        if self.prefs.integer(forKey: kTimeOutKey) == 0 {
            self.prefs.set(kDefaultTime, forKey: kTimeOutKey)
        }
        
    }
    
    class func save(key: String, value: Int){
        
        self.prefs.setValue(value, forKey: key)
        
    }
    
    class func load(key:String) -> Int{
        
        self.prefs.integer(forKey: key)
        
    }
    
    class func add(key: String, value: [Int: Int]){
        
        var tmp: [String: Int] = load(key: key)

        tmp.updateValue(value.values.first!, forKey: "\(value.keys.first!)")
        
        save(key: key, value: tmp)
    }
    
    class func save(key: String, value: [String: Int]){
        
        self.prefs.set(value, forKey: key)
        
    }
    
    class func load(key:String) -> [String: Int]{
        
        self.prefs.object(forKey: key) as? [String: Int] ?? [:]
        
    }
    
}
