//
//  Utility.swift
//  work_5
//
//  Created by Stanislav Belsky on 27.04.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

class Utility{
    
    static func createFileIfNeeded(_ fileName: String){
        
        let fileManager = FileManager.default
        let documentDirectory = getDocumentsDirectory()
        
        let jsonFilePath = documentDirectory.appendingPathComponent(fileName)
        var isDirectory: ObjCBool = false

        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: jsonFilePath.absoluteString, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: jsonFilePath.path, contents: nil, attributes: nil)
            if created {
                print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            print("File already exists")
        }
        
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
