//
//  CacheManager.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation

enum FileType: String{
    
    case Config = "config.json"
    
}

struct CacheManager {
    
    static func save<T: Codable>(data: T, fileType: FileType){
        
        var jsonData: Data!
        do {
            let encoder = JSONEncoder()

            jsonData = try encoder.encode(data)
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }

        Self.createFileIfNeeded(fileType: fileType)

        do {
            
            let directory = Self.getCacheDirectory()
            
            let jsonFilePath = directory.appendingPathComponent(fileType.rawValue)
            let file = try FileHandle(forWritingTo: jsonFilePath)
            file.write(jsonData)
            print("JSON data was written to \(fileType.rawValue) file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
        
    }
    
    static func load<T: Codable>(fileType: FileType) -> T?{
        
        do {
            let directory = Self.getCacheDirectory()
            
            let fileURL = directory.appendingPathComponent(fileType.rawValue)
            
            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
            let decoder = JSONDecoder()
            let tmp = try decoder.decode(T.self, from: data)
            print("Load from \(fileType.rawValue) for store: \(tmp)")
            
            return tmp
            
        } catch let error {
            print("parse error: \(error.localizedDescription)")
            save(data: ConfigData(), fileType: .Config)
            return nil
        }
    }
    
    static func createFileIfNeeded(fileType: FileType){

        let fileManager = FileManager.default
        let documentDirectory = Self.getCacheDirectory()
        
        let jsonFilePath = documentDirectory.appendingPathComponent(fileType.rawValue)
        var isDirectory: ObjCBool = false

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
    
    static func getCacheDirectory() -> URL {
        let path = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        return path
    }
}
