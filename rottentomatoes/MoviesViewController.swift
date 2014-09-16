//
//  MoviesViewController.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var moviesSearchBar: UISearchBar!

    var moviesArray = Array<RottenTomatoesMovie>()
    var visibleMoviesArray = Array<RottenTomatoesMovie>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = "Loading"
        getMoviesFromRottenTomatoes() {
            (moviesResultDictionary: NSDictionary) -> () in
            let movieDictionaries = moviesResultDictionary["movies"] as? NSArray
            var moviesArray = Array<RottenTomatoesMovie>()
            for movieDictionary in movieDictionaries! {
                let movie = getRottenTomatoesMovieInstance(movieDictionary as NSDictionary)
                moviesArray.append(movie)
            }
            self.moviesArray = moviesArray
            self.visibleMoviesArray = moviesArray
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.movieTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.visibleMoviesArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieTableViewCell = movieTableView.dequeueReusableCellWithIdentifier("com.hacktoolkit.rottentomatoes.movieCell") as MovieTableViewCell
        let movie = self.visibleMoviesArray[indexPath.row]
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

    func updateVisibleMovies(filterTitle substring: String) {
        if substring == "" {
            self.visibleMoviesArray = self.moviesArray
        } else {
            var visibleMoviesArray = Array<RottenTomatoesMovie>()
            for movie in self.moviesArray {
                let rangeValue = (movie.title as NSString).rangeOfString(substring, options: NSStringCompareOptions.CaseInsensitiveSearch)
                if rangeValue.location != NSNotFound {
                    visibleMoviesArray.append(movie)
                }
            }
            self.visibleMoviesArray = visibleMoviesArray
        }
        self.movieTableView.reloadData()
    }

    // UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        updateVisibleMovies(filterTitle: searchText)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let movieDetailsViewController = segue.destinationViewController as? MovieDetailsViewController {
            if let movieCell = sender as? MovieTableViewCell {
                movieDetailsViewController.setMovieCellSender(movieCell)
            }
        }
    }
}

