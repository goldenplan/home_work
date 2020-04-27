//
//  StateService.swift
//  work_5
//
//  Created by Stanislav Belsky on 27.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

struct StateData: Codable {
    let lastSearch: String
}

class StateService{
    
    static let fileName = "state.json"
    
    static func saveState(_ state: StateData){
        
        Utility.createFileIfNeeded(fileName)
        
        // creating JSON out of the above array
        var jsonData: Data!
        do {
            let encoder = JSONEncoder()
            
            jsonData = try encoder.encode(state)
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            print(jsonString ?? "nil")
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }

        // Write that JSON to the file created earlier
        
        do {
            let fileManager = FileManager.default
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let jsonFilePath = documentDirectory.appendingPathComponent(fileName)
            let file = try FileHandle(forWritingTo: jsonFilePath)
            file.write(jsonData)
            print("JSON data was written to \(fileName) file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
        
    }
    
    static func loadState() -> StateData?{
        
        let fileManager = FileManager.default

        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
            let decoder = JSONDecoder()
            let state = try decoder.decode(StateData.self, from: data)
            print("State: \(state)")
            
            return state
            
        } catch let error {
            print("parse error: \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
