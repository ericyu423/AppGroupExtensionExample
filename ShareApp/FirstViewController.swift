//
//  RedViewController.swift
//  ShareApp
//
//  Created by eric yu on 11/16/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let suitName = "group.ShareApp.example"
    let defaultKey = "defaultKey1"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        if let userDefault = UserDefaults(suiteName: suitName) {
            if let imageData = userDefault.object(forKey: defaultKey) as? Data{
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data:imageData)
                }
            }
        }
    
    }
}
