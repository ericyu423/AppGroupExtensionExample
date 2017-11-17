//
//  NameSelectionTableViewController.swift
//  ShareAppShareExtension
//
//  Created by eric yu on 11/16/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices


 @objc(NameSelectionTableViewControllerDelegate)
protocol NameSelectionTableViewControllerDelegate{
      @objc optional func nameSelection(_ sender: UITableViewController,selectedValue: String)
}

class NameSelectionTableViewController: UITableViewController {
    
    let viewSelections = ["Default","1","2"]
    let tableViewCellIdentifier = "reuseIdentifier"
    var selectedViewName = "Default"
    var delegate: NameSelectionTableViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Initialize the tableview
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.register(UITableViewCell.classForCoder(),
                           forCellReuseIdentifier: tableViewCellIdentifier)
        title = "Choose ViewController"
    }
    
    /*override func viewDidLoad() {
        super.viewDidLoad()

       tableView.register(UITableViewCell.classForCoder(),
                               forCellReuseIdentifier: tableViewCellIdentifier)
            title = "Choose ViewController"
     
    }*/

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        let text = viewSelections[indexPath.row]
        cell.textLabel!.text = text
        
        if text == selectedViewName {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let theDelegate = delegate {
             selectedViewName = viewSelections[indexPath.row]
             theDelegate.nameSelection!(self, selectedValue: selectedViewName)
        }
    }
}
