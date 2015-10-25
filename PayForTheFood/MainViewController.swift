//
//  MainViewController.swift
//  PayForTheFood
//
//  Created by Timothy Horng on 10/25/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import UIKit
import Parse

let appGroupID = "group.com.timothyhorng.payforfood"

class MainViewController: UIViewController {

    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var restaurantChosenLabel: UILabel!
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    var time: NSDate?
    
    @IBAction func updateButton(sender: UIBarButtonItem) {
        print("update function called")
        updateLabels()
    }
    @IBAction func updateButtonPressed(sender: UIButton) {
        updateLabels()
    }
    
    func fetch(completion: () -> Void) {
        time = NSDate()
        completion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("why the fuck isn't this printing")
        updateLabels()
        registerBackgroundTask()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
            [unowned self] in
            self.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        NSLog("Background task ended.")
        UIApplication.sharedApplication().endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    func updateLabels() {
        
        let defaults =  NSUserDefaults(suiteName: appGroupID)
        
        if let customerName = defaults?.stringForKey("customerName"), restaurantSelected = defaults?.stringForKey("restaurantSelected") {
            customerNameLabel.text = customerName
            restaurantChosenLabel.text = restaurantSelected
        }
        
    }
    
    func uploadToParse() {
        
        let defaults =  NSUserDefaults(suiteName: appGroupID)
        
        if let customerName = defaults?.stringForKey("customerName"), restaurantSelected = defaults?.stringForKey("restaurantSelected") {
            let customerObject = PFObject(className: "CustomerObject")
            customerObject["customerName"] = customerName
            customerObject["restaurantChosen"] = restaurantSelected
            customerObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("customerObject saved!")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
