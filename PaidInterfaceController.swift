//
//  PaidInterfaceController.swift
//  PayForTheFood
//
//  Created by Timothy Horng on 10/25/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import WatchKit
import Foundation


class PaidInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        let dictionary: NSMutableDictionary = ["InvoiceNo":"1",
            "RefNo":"1",
            "Memo":"Team2 Money2020",
            "Purchase":"1.00",
            "Frequency":"OneTime",
            "RecordNo":"RecordNumberRequested",
            "EncryptedFormat":"MagneSafe",
            "AccountSource":"Swiped",
            "EncryptedBlock":"2F8248964608156B2B1745287B44CA90A349905F905514ABE3979D7957F13804705684B1C9D5641C",
            "EncryptedKey":"9500030000040C200026",
            "OperatorID":"money2020"]
        
        processTransactionWithDictionary(dictionary, resource: "https://w1.mercurycert.net/PaymentsAPI/Credit/Sale")
        
        
    }
    
    func processTransactionWithDictionary(dictionary: NSDictionary, resource: NSString) {
        let request = NSMutableURLRequest(URL: NSURL(string: resource as String)!)
        let session = NSURLSession.sharedSession()
        
        request.timeoutInterval = 30
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let credentials: String = "6013521114:xyz"
        let utf8str = credentials.dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = utf8str!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        request.addValue("Basic \(base64Encoded)", forHTTPHeaderField: "Authorization")
        
        var data: NSData = NSData()
        
        do {
            data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
            print("data printed?")
            print("\(data)")
        } catch {
            print("something bad happened")
        }
        
        let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        print(dataString)
        
        request.setValue("\(data.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = data
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let receivedData = data {
                print("\(receivedData)")
            }
            print("Response: \(response)")
        }
        
//        let urlConnection = NSURLConnection(request: request, delegate: self)
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//            var err: NSError
//            var jsonResult: NSDictionary = NSDictionary()
//            do {
//                var jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            } catch {
//                print("wow")
//            }
//            print("\(jsonResult)")
//        })
        
        super.willActivate()
        
        task.resume()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        var result: [NSObject : AnyObject] = [:]
        do {
            result = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [NSObject : AnyObject]
        } catch {
            print("whoops")
        }
        if let resultCmdStatus = result["CmdStatus"] where resultCmdStatus.isEqualToString("Approved") {
            print("YEAA")
        }
        else {
            print("shit")
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
