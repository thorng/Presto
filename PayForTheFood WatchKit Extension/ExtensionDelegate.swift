//
//  ExtensionDelegate.swift
//  PayForTheFood WatchKit Extension
//
//  Created by Timothy Horng on 10/24/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import WatchKit
import Parse
import Bolts

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        
        // Enable data sharing in app extensions.
//        Parse.enableDataSharingWithApplicationGroupIdentifier("group.com.timothyhorng.payforfood",
//            containingApplication: "com.timothyhorng.PayForTheFood")
        // Setup Parse
//        Parse.setApplicationId("FMpOZ3pGmgoKxs5eAkml0W4JOItxcNSxykrBLFTO", clientKey: "GZKolYxmca3XFyA9cDT84bKwsHVRdwpeN8KToxHL")
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
