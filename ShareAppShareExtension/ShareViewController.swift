//
//  ShareViewController.swift
//  ShareAppShareExtension
//
//  Created by eric yu on 11/16/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController,NameSelectionTableViewControllerDelegate {
    func nameSelection(_ sender: UITableViewController, selectedValue: String) {
        vcConfigurationItem.value = selectedValue
        selectViewName = selectedValue
        popConfigurationViewController()
    }
 
    let suiteName = "group.ShareApp.example"
    let defaultKey1 = "defaultKey1"
    let defaultKey2 = "defaultKey2"
    
    var selectedImage: UIImage?
    var selectViewName = "default"
 
    
    func showNameSelection(){
        //stuff from parent app
        let controller = NameSelectionTableViewController(style: .plain)
        controller.selectedViewName = vcConfigurationItem.value
        controller.delegate = self
        pushConfigurationViewController(controller)
    }

    override func isContentValid() -> Bool {
        return true
    }

    
    override func didSelectPost() {
        let contentType = kUTTypeImage as String
        
        guard let extensionItem: NSExtensionItem = extensionContext!.inputItems[0] as? NSExtensionItem  else {
            return
        }
        guard let itemProvider: [NSItemProvider] = extensionItem.attachments as? [NSItemProvider] else {
            return
        }
        
        for attachment in itemProvider{
      
            if attachment.hasItemConformingToTypeIdentifier(contentType){
                attachment.loadItem(forTypeIdentifier: contentType, options: nil
                    , completionHandler: { (secureCodingData, error) in
                        let url = secureCodingData as! URL
                        
                        if(!self.selectViewName.isEmpty){
                            if let imageData = try? Data(contentsOf: url){
                                
                                switch self.selectViewName {
                                case "Default":
                                    self.saveImage(self.defaultKey1 , imageData: imageData)
                                    self.saveImage(self.defaultKey2 , imageData: imageData)
                                case "1":
                                     self.saveImage(self.defaultKey1, imageData: imageData)
                                case "2":
                                     self.saveImage(self.defaultKey2, imageData: imageData)
                                default:
                                    break
                            }
                        }
                    }
                })
            }}
       
        
        
        //unblock the UI
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {

        return [vcConfigurationItem]
    }
    
    
    lazy var vcConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "Views"
        item?.value = self.selectViewName
        item?.tapHandler = self.showNameSelection
        
        return item!
    }()
}

extension ShareViewController {
    func nameSelection(_ sender: NameSelectionTableViewController,selectedValue: String){
       
        vcConfigurationItem.value = selectViewName
        
        selectViewName = selectedValue
        
        popConfigurationViewController()
    }
    
    func saveImage(_ viewKey: String,imageData: Data){
        if let userDefault = UserDefaults(suiteName: suiteName) {
            userDefault.removeObject(forKey: viewKey)
            userDefault.set(imageData, forKey: viewKey)
        }
        
    }
    
    
}
