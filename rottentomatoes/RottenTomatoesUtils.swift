//
//  RottenTomatoesUtils.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import Foundation
import UIKit

let ROTTEN_TOMATOES_API_BOX_OFFICE_MOVIES_URL = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=\(ROTTEN_TOMATOES_API_KEY)&limit=20&country=us"

let ROTTEN_TOMATOES_API_TOP_RENTALS_URL = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + ROTTEN_TOMATOES_API_KEY

func getMoviesFromRottenTomatoes(callback: (NSDictionary) -> ()) {
    let request = NSMutableURLRequest(URL: NSURL.URLWithString(ROTTEN_TOMATOES_API_BOX_OFFICE_MOVIES_URL))
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) in
        var errorValue: NSError? = nil
        let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue)
        if parsedResult != nil {
            let moviesResultDictionary = parsedResult! as NSDictionary
            callback(moviesResultDictionary)
        }
    })
}

var rottenTomatoesMovieObjects = Dictionary<String, RottenTomatoesMovie>()

func getRottenTomatoesMovieInstance(movieDictionary: NSDictionary) -> RottenTomatoesMovie {
    let movieId = movieDictionary["id"] as NSString
    var movie: RottenTomatoesMovie?
    if let movieInstance = rottenTomatoesMovieObjects[movieId] {
        movie = movieInstance
    } else {
        movie = RottenTomatoesMovie(movieDictionary: movieDictionary)
        rottenTomatoesMovieObjects[movieId] = movie
    }
    return movie!
}
