import UIKit

var str = "Hello, playground"

@objc func startOperation() {

      
      let dispatchQueue = DispatchQueue(label: "com.alfianlosari.test", qos: .userInitiated, attributes: .concurrent)
      let dispatchGroup = DispatchGroup()
    let dispatchSemaphore = DispatchSemaphore(value: .max)
  
}
