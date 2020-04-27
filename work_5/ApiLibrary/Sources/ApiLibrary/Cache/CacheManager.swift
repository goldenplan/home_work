//
//  File.swift
//  
//
//  Created by Stanislav Belsky on 27.04.2020.
//

import Foundation
import Combine

enum CacheFiles: String{
    
    case Movies = "movies.json"
    
    static func getName<T>(type: T.Type) -> String?{
        
        if type is MovieData.Type{
            return Self.Movies.rawValue
        }
        
        return nil
    }
}

public class CacheManager{
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(){}
    
//    public func getResults<T: Codable>(search: String) -> [T]{
//        
//        do{
//        
//            var tmp = [T]()
//            
//            let fileManager = FileManager.default
//            
//            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
//            
//            guard let cacheName = CacheFiles.getName(type: T.self) else{
//                return []
//            }
//            
//            let fileURL = documentDirectory.appendingPathComponent(cacheName)
//            
//            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
//            
//            let decoder = JSONDecoder()
//            tmp = try decoder.decode([T].self, from: data)
//            print("results: \(tmp)")
//            
//            return tmp
//            
//        }catch{
//            return []
//        }
//        
//    }
    
    public func getResults<T: Codable>(filter: String, type: T.Type) -> Future<[T], Error>{
        
        return Future<[T], Error>{ promise in
            do{
                
                var tmp = [T]()
                
                let fileManager = FileManager.default
                
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                
                guard let cacheName = CacheFiles.getName(type: T.self) else{
                    promise(.failure(ApiError.cacheError("Unknown item")))
                    return
                }
                
                let fileURL = documentDirectory.appendingPathComponent(cacheName)
                
                let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
                
                let decoder = JSONDecoder()
                tmp = try decoder.decode([T].self, from: data)
                print("Load from \(cacheName): \(tmp.count)")
                
                if !filter.isEmpty && type is MovieData.Type{
                    let filtered = tmp.filter { (item) -> Bool in
                        return (item as! MovieData).title.contains(filter)
                    }
                    promise(.success(filtered))
                }else{
                    promise(.success(tmp))
                }
                
            }catch{
                promise(.failure(ApiError.cacheError("No cache")))
            }
        }
    }
    
    public func loadResults<T: Codable>() -> [T]{
        
        var tmp = [T]()
        
        let fileManager = FileManager.default

        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            
            guard let cacheName = CacheFiles.getName(type: T.self) else{
                print("Unknown item for load in cache")
                return []
            }
            
            let fileURL = documentDirectory.appendingPathComponent(cacheName)
            
            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
            let decoder = JSONDecoder()
            tmp = try decoder.decode([T].self, from: data)
            print("Load from \(cacheName) for store: \(tmp.count)")
            
            return tmp
            
        } catch let error {
            print("parse error: \(error.localizedDescription)")
            return tmp
        }

    }
    
    func storeResult<T: Codable>(result: [T]){
        
        let saved: [T] = loadResults()
        
        if let newResults = result as? [MovieData],
            let oldResults = saved as? [MovieData]{
            
            var tmp = newResults
            let newIds = newResults.map{$0.id}
            tmp.append(contentsOf: oldResults.filter({ (item) -> Bool in
                return !newIds.contains(item.id)
            }))
            
            createFileIfNeeded(cacheName: .Movies)
            
            saveResult(results: tmp)
            
        }

    }

    func saveResult<T: Codable>(results: [T]){
        
        // creating JSON out of the above array
        var jsonData: Data!
        do {
            let encoder = JSONEncoder()

            jsonData = try encoder.encode(results)
//            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
//            print(jsonString ?? "nil")
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }

        // Write that JSON to the file created earlier

        do {
            let fileManager = FileManager.default
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            
            guard let cacheName = CacheFiles.getName(type: T.self) else{
                print("Unknown item for load in cache")
                return
            }
            
            let jsonFilePath = documentDirectory.appendingPathComponent(cacheName)
            let file = try FileHandle(forWritingTo: jsonFilePath)
            file.write(jsonData)
            print("JSON data was written to \(cacheName) file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
        
    }
    
    func createFileIfNeeded(cacheName: CacheFiles){

        let fileManager = FileManager.default
        let documentDirectory = Self.getDocumentsDirectory()
        
        let jsonFilePath = documentDirectory.appendingPathComponent(cacheName.rawValue)
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
