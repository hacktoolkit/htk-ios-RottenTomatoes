//
//  Movie.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/15/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import Foundation

class RottenTomatoesMovie {
//    var movieDictionary: NSDictionary

    var id: String
    var title: String
    var year: Int
    var mpaaRating: String
    var synopsis: String
    // posters
    var thumbnailPosterUrl: String
    var profilePosterUrl: String
    var detailedPosterUrl: String
    var originalPosterUrl: String
    // ratings
    var criticsRating: String
    var criticsScore: Int
    var audienceRating: String
    var audienceScore: Int

    init(movieDictionary: NSDictionary) {
//        self.movieDictionary = movieDictionary
        self.id = movieDictionary["id"] as? NSString ?? ""
        self.title = movieDictionary["title"] as? NSString ?? ""
        self.year = movieDictionary["year"] as? Int ?? 0
        self.mpaaRating = movieDictionary["mpaa_rating"] as? NSString ?? ""
        self.synopsis = movieDictionary["synopsis"] as? NSString ?? ""

        // movie posters
        let posters = movieDictionary["posters"] as NSDictionary
        self.thumbnailPosterUrl = posters["thumbnail"] as? NSString ?? ""
        self.profilePosterUrl = (posters["profile"] as? NSString ?? "").stringByReplacingOccurrencesOfString("_tmb", withString: "_pro")
        self.detailedPosterUrl = (posters["detailed"] as? NSString ?? "").stringByReplacingOccurrencesOfString("_tmb", withString: "_det")
        self.originalPosterUrl = (posters["original"] as? NSString ?? "").stringByReplacingOccurrencesOfString("_tmb", withString: "_ori")

        // ratings
        let ratings = movieDictionary["ratings"] as NSDictionary
        self.criticsRating = ratings["critics_rating"] as? NSString ?? ""
        self.criticsScore = ratings["critics_score"] as? Int ?? 0
        self.audienceRating = ratings["audience_rating"] as? NSString ?? ""
        self.audienceScore = ratings["audience_score"] as? Int ?? 0
    }

}
