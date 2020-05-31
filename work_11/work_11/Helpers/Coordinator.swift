//
//  Coordinator.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/30/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class Coordinator: NSObject {
    
    let loadingQueue = DispatchQueue(label: "work_11.loading.queue", qos: .userInitiated, attributes: .concurrent)
    let dispatchGroup = DispatchGroup()
    let dispatchSemaphore = DispatchSemaphore(value: .max)
    
//    let authItem = DispatchWorkItem(qos: <#T##DispatchQoS#>, flags: .barrier, block: <#T##() -> Void#>)
    
    var sceneDelegate:SceneDelegate?{
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
          return nil
        }
        
        return windowScene.delegate as? SceneDelegate
    }
    
    var rootViewController: UIViewController?{
        get{
            guard let sceneDelegate = sceneDelegate else{
              return nil
            }
            return sceneDelegate.window?.rootViewController
        }
        set(newController){
            guard let sceneDelegate = sceneDelegate else{
                return
            }
            sceneDelegate.window?.rootViewController = newController
            
        }
        
    }
    
    static let instance = Coordinator()
    
    override init() {
        super.init()
        
        setupReachability()
    }
    
    func show<T: View>(contentView: T){
        DispatchQueue.main.async{
            self.rootViewController = UIHostingController(rootView: contentView)
        }
    }
    
    func showMainVindow(){
        DispatchQueue.main.async {
            if let sceneDelegate = self.sceneDelegate{
                sceneDelegate.window!.makeKeyAndVisible()
            }
        }
        
    }
    
    func showLoadingWindow() {
        DispatchQueue.main.async {
            if let sceneDelegate = self.sceneDelegate{
                sceneDelegate.loadingWindow!.makeKeyAndVisible()
            }
        }
    }
    
    func restart() {
        
        showLoadingWindow()
        
        print("======================= startLoading")
        
        var loadingData = LoadingData()
        
        dispatchGroup.enter()
        loadingQueue.async(group: dispatchGroup, qos: .userInitiated, flags: .barrier) {
            AuthApi.shared.isAuth { [weak self] (result) in
                guard let strongSelf = self else { return }
                
                switch result{
                case .success(let value):
                    loadingData.isAuthorized = value
                case .failure(_):
                    loadingData.isAuthorized = false
                }
                print("Tast finish: Auth")
                strongSelf.dispatchGroup.leave()
            }
        }
        
        
        dispatchGroup.enter()
        loadingQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            let completion: ((Result<Bool,Error>)->()) = { result in
                
                strongSelf.showLoadingWindow()
                
                switch result {
                case .success(let value):
                    loadingData.isPinSuccess = value
                default:
                    break
                }
                
                print("Tast finish: Pincode")
                strongSelf.dispatchGroup.leave()
            }
            
            if let isAuth = loadingData.isAuthorized, !isAuth{
                loadingData.isPinSuccess = false
                strongSelf.dispatchGroup.leave()
                return
            }
            
            let config = ConfigData.load()
            if config.isNeedPinEnter{
                strongSelf.show(contentView: PinEnterView().environmentObject(PinEnterViewModel(completion: completion)))
                strongSelf.showMainVindow()
            }else{
                print("Tast finish: Pincode")
                loadingData.isPinSuccess = true
                strongSelf.dispatchGroup.leave()
            }
            
        }
        
        dispatchGroup.enter()
        loadingQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            loadingData.isReachable = Network.reachability.isReachable
            print("Tast finish: Network")
            strongSelf.dispatchGroup.leave()
        }
        
//        let result = dispatchGroup.wait(timeout: .distantFuture)
        
        dispatchGroup.enter()
        loadingQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            loadingData.defaultViewType = ConfigData.load().startViewType
            print("Tast finish: Default View")
            strongSelf.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: loadingQueue){ [weak self] in
            guard let strongSelf = self else { return }
            
            print("======================= startLoading end")
            strongSelf.show(contentView: loadingData.detectStartView())
            strongSelf.showMainVindow()
        }
        
        
    }
    
    func detectView(by loadingData: LoadingData){
        
    }
    
}


extension Coordinator: UIWindowSceneDelegate{
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let sceneDelegate = sceneDelegate,
            let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            sceneDelegate.window = window
            
            let loadingWindow = UIWindow(windowScene: windowScene)
            sceneDelegate.loadingWindow = loadingWindow
            loadingWindow.rootViewController = UIHostingController(rootView: SplashView())
            
            restart()
        }
        
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        print("application_openURL", url)

    }
    
    @objc func statusManager(){
        
        switch Network.reachability.status {
        case .unreachable:
            print("unreachable")
        case .wwan:
            print("wwan")
        case .wifi:
            print("wifi")
            
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
        
        restart()
        
    }
    
    func setupReachability(){
           
       do {
           try Network.reachability = Reachability(hostname: "www.google.com")
       }
       catch {
           switch error as? Network.Error {
           case let .failedToCreateWith(hostname)?:
               print("Network error:\nFailed to create reachability object With host named:", hostname)
           case let .failedToInitializeWith(address)?:
               print("Network error:\nFailed to initialize reachability object With address:", address)
           case .failedToSetCallout?:
               print("Network error:\nFailed to set callout")
           case .failedToSetDispatchQueue?:
               print("Network error:\nFailed to set DispatchQueue")
           case .none:
               print(error)
           }
       }
        
        NotificationCenter.default.addObserver(self,
                     selector: #selector(statusManager),
                     name: .flagsChanged,
                     object: nil)
           
       }
}
