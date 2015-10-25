//
//  Network.swift
//  PayForTheFood
//
//  Created by Timothy Horng on 10/24/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

// Requesting from Google Places API
private let GOOGLE_PLACES_API_KEY: String = "AIzaSyAKtrEj6qZ17YcjfD4SlijGbZd96ZZPkRM"

class Network {
    
    class func get(urlString:String, completionHandler: ((NSDictionary?) -> Void)?, errorHandler:(() -> Void)?) {
        if let url = NSURL(string: urlString) {
            let request = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                Network.handleRESTResponse(completionHandler, data: data, response: response, error: error,  errorHandler: errorHandler)
            })
            task.resume()
        }
    }
    
    class func handleRESTResponse(completionHandler: ((NSDictionary?) -> Void)?, data:NSData?, response:NSURLResponse?, error: NSError?, errorHandler:(() -> Void)?){
        
        let json: NSDictionary?
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves
                ) as? NSDictionary
        } catch _ {
            json = nil
            print("uh oh. json returned nil, so there's some sort of error.")
        }

        if let parseJSON = json {
            completionHandler?(parseJSON)
        } else {
            print("Very bad error")
            errorHandler?()
        }
    }
    
    // MARK: Google Search Request
    class func buildSearchURL() -> String {
        let placeSearchString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=36.121452,-115.169611&radius=100&&types=food&key=" + GOOGLE_PLACES_API_KEY
        
        return placeSearchString
    }
    
    class func getGooglePlaces(url: String, completionHandler: [NSDictionary]? -> Void) {
        
        // Fetch the restaurant
        Network.get(url, completionHandler: { data -> Void in
            if let json = data, places = json["results"] as? [NSDictionary] {
                completionHandler(places)
            } else {
                print("Something happened with Network 'get' request. Maybe bad internet connection")
                completionHandler(nil)
            }
            }, errorHandler: nil)
    }
    
}