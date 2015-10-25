//
//  CardEntryTableViewController.swift
//  PayForTheFood
//
//  Created by Timothy Horng on 10/24/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import Parse
import UIKit

class CardEntryTableViewController: UITableViewController {

    var cardObject: CardObject?
    
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveCardInformation" {
            
            let cardObject = PFObject(className: "CardClass")
            cardObject["cardNumber"] = cardNumber.text
            cardObject["expirationDate"] = expirationDate.text
            cardObject["securityCode"] = securityCode.text
            cardObject["zipCode"] = zipCode.text
            cardObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("cardObject saved!")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Table view data source

}
