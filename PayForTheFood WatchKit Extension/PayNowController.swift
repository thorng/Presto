//
//  PayNowController.swift
//  PayForTheFood
//
//  Created by Timothy Horng on 10/24/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import WatchKit
import Foundation

class PayNowController: WKInterfaceController {
    
    @IBOutlet var payNowButton: WKInterfaceButton!
    @IBOutlet var titleText: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        

        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        titleText.setText("Grand Lux Cafe")
        payNowButton.setTitle("Pay Now ($0.00)")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
