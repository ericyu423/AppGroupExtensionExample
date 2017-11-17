//
//  SecondViewController.swift
//  ShareApp
//
//  Created by eric yu on 11/16/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageVIew: UIImageView!
    
    let suitName = "group.ShareApp.example"
    let defaultKey = "defaultKey2"

    override func viewDidLoad() {
        super.viewDidLoad()
        if let userDefault = UserDefaults(suiteName: suitName) {
            if let imageData = userDefault.object(forKey: defaultKey) as? Data{
                DispatchQueue.main.async {
                    self.imageVIew.image = UIImage(data:imageData)
                }
            }
        }
    }

}
