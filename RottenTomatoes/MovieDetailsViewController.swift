//
//  MovieDetailsViewController.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var fullPosterImage: UIImageView!
    @IBOutlet weak var movieDetailsContainer: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var criticsScoreLabel: UILabel!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!

    var movie: RottenTomatoesMovie?
    var movieCellSender: MovieTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.movie != nil {
            self.renderViewForMovie(movie!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMovieCellSender(movieCell: MovieTableViewCell) {
        self.movieCellSender = movieCell
        self.movie = movieCell.movie!
    }

    func renderViewForMovie(movie: RottenTomatoesMovie) {
        self.navigationItem.title = movie.title
        movie.displayOriginalPosterIn(self.fullPosterImage)
        self.movieTitleLabel.text = "\(movie.title) (\(movie.year))"
        self.criticsScoreLabel.text = "Critics Score: \(movie.criticsScore), Audience Score: \(movie.audienceScore)"
        self.mpaaRatingLabel.text = movie.mpaaRating
        self.synopsisLabel.text = movie.synopsis
        self.synopsisLabel.sizeToFit()
    }

    @IBAction func onMovieDetailsTap(sender: AnyObject) {
        // POP animations not working
//        var anim = POPBasicAnimation(propertyNamed: "kPOPLayerPosition")
//        anim.duration = 0.3
//        anim.toValue = NSValue(CGPoint: CGPointMake(CGFloat(0.0), CGFloat(64.0)))
//        self.movieDetailsContainer.pop_addAnimation(anim, forKey: "anim")

//        let direction = (self.movieDetailsContainer.frame.minY == CGFloat(NAVIGATION_BAR_MAX_Y)) ? 0 : -1
//        let yShift = CGFloat((MOVIE_DETAILS_CONTAINER_START_Y - NAVIGATION_BAR_MAX_Y) * direction)
//        UIView.animateWithDuration(0.2, animations: {
//            self.movieDetailsContainer.transform = CGAffineTransformMakeTranslation(0, yShift)
//        })
    }
}
