//
//  MoviesViewController.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    var moviesArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesFromRottenTomatoes() { (moviesResultDictionary: NSDictionary) -> () in
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
        movieTableViewCell.formatWithMovieDataDictionary(movieDictionary)
        
        return movieTableViewCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsViewController = MovieDetailsViewController(nibName: nil, bundle: nil)

        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

