//
//  ShareViewController.swift
//  SharingExtension
//
//  Created by Stanislav Belsky on 5/24/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    private var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setupUI()
        getText()
        
    }
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
//        if !text.isEmpty{
            let codedText: String = text.toBase64() ?? "nil"
            openURL(URL(string: "worknine://new?text=\(codedText)")!)
//        }
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    private func setupUI() {

        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.topItem?.titleView = imageView
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(red:1, green:0, blue:0, alpha:1.00)
    }
    
    private func getText(){
            print("getText")
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        guard let attachments = extensionItem.attachments,
            let itemProvider = attachments.first
        else { return }
        
//        self.link = "\(itemProvider.registeredTypeIdentifiers)"
        
        let type = "public.plain-text"
        if itemProvider.hasItemConformingToTypeIdentifier(type) {
            itemProvider.loadItem(forTypeIdentifier: type, options: nil, completionHandler: { (item, error) -> Void in
                guard let text = item as? String else { return }
                self.text = text
            })
        }
        
    }
    
    
    @discardableResult
    @objc func openURL(_ url: URL) -> Bool {
        print("openURL", url)
        var responder: UIResponder? = self
        while responder != nil {
            print("responder",responder ?? "nil")
            if let application = responder as? UIApplication {
                print("application", application)
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }

}
