//
//  RottenTomatoesUtils.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import Foundation
import UIKit

let ROTTEN_TOMATOES_BOX_OFFICE_MOVIES_API_URL = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=\(ROTTEN_TOMATOES_API_KEY)&limit=20&country=us"

let ROTTEN_TOMATOES_TOP_RENTALS_API_URL = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + ROTTEN_TOMATOES_API_KEY

func getMoviesFromRottenTomatoes(callback: (NSDictionary) -> ()) {
    let request = NSMutableURLRequest(URL: NSURL.URLWithString(ROTTEN_TOMATOES_BOX_OFFICE_MOVIES_API_URL))
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
        var errorValue: NSError? = nil
        let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue)
        if parsedResult != nil {
            let moviesResultDictionary = parsedResult! as NSDictionary
            callback(moviesResultDictionary)
        }
    })
}