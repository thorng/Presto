//
//  InterfaceController.swift
//  PayForTheFood WatchKit Extension
//
//  Created by Timothy Horng on 10/24/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import WatchKit
import Foundation
import Parse
import Bolts

let appGroupID = "group.com.timothyhorng.payforfood"

class InterfaceController: WKInterfaceController {

    var selectedIndex: Int = 0
    let pickerItems: [WKPickerItem] = []
    var pickerItemsNames: [String] = []
    
    @IBOutlet var picker: WKInterfacePicker!
    
    @IBAction func pickerSelection(value: Int) {
        selectedIndex = value
        print("pickerItems: index \(value) selected.")
    }
    
    @IBAction func checkInButtonPressed() {
        sendDataToPhone()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        startNetworkRequest(pickerItems)
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func startNetworkRequest(var pickerItems: [WKPickerItem]) {
        print("Starting network request...")
        
        let url = Network.buildSearchURL()
        
        Network.getGooglePlaces(url, completionHandler: { response -> Void in
            if let dict = response {
                for index in 0..<dict.count {
                    let item = WKPickerItem()
                    
                    item.title = dict[index]["name"] as? String
                    pickerItems.append(item)
                    self.pickerItemsNames.append(item.title!)
                    print("\(pickerItems[index])")
                    
                }
                
                self.picker.setItems(pickerItems)
            }
        })
        
    }
    
    func sendDataToPhone() {
        if let defaults = NSUserDefaults(suiteName: appGroupID) {
            defaults.setValue("Timothy Horng", forKey: "customerName")
            defaults.setValue(pickerItemsNames[selectedIndex], forKey: "restaurantSelected")
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
//        let customerObject = PFObject(className: "CustomerObject")
//        customerObject["customerName"] = "John Cena"
//        customerObject["restaurantChosen"] = pickerItems[selectedIndex]
//        
//        customerObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("cardObject saved!")
//        }
        
        sendDataToPhone()
        
        return pickerItemsNames[selectedIndex]
    }
}
