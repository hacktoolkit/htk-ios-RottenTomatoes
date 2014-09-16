//
//  MoviesViewController.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var movieTableView: UITableView!
    var moviesArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = "Loading"
        getMoviesFromRottenTomatoes() {
            (moviesResultDictionary: NSDictionary) -> () in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.moviesArray = moviesResultDictionary["movies"] as? NSArray
            self.movieTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesArray != nil {
            return moviesArray!.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let movieTableViewCell = movieTableView.dequeueReusableCellWithIdentifier("com.hacktoolkit.rottentomatoes.movieCell") as MovieTableViewCell
        let movieDictionary = self.moviesArray![indexPath.row] as NSDictionary
        let movie = getRottenTomatoesMovieInstance(movieDictionary)
        movieTableViewCell.formatWithMovie(movie)

        return movieTableViewCell
    }

    // Can use this function if implementing the protocol UITableViewDelegate
    //
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let movieDetailsViewController = MovieDetailsViewController(nibName: nil, bundle: nil)
//
//        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
//    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let movieDetailsViewController = segue.destinationViewController as? MovieDetailsViewController {
            if let movieCell = sender as? MovieTableViewCell {
                movieDetailsViewController.setMovieCellSender(movieCell)
            }
        }
    }
}

