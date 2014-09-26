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

    var movies: [RottenTomatoesMovie]!
    var visibleMovies: [RottenTomatoesMovie]!
    var movieType: RottenTomatoesApiMovieType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: "tableRefreshCallback:", forControlEvents: UIControlEvents.ValueChanged)
        self.movieTableView!.addSubview(refreshControl)
        self.reloadData()
    }

    func setMovieType(movieType: RottenTomatoesApiMovieType) {
        self.movieType = movieType
    }

    func reloadData(showHud: Bool = true, refreshControl: UIRefreshControl? = nil) {
        if showHud {
            var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            //        hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = "Loading"
        }
        RottenTomatoesClient.getMovies(self.movieType ?? RottenTomatoesApiMovieType.Movies) {
            (movies: [RottenTomatoesMovie]) -> () in
            self.movies = movies
            self.visibleMovies = movies
            if showHud {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
            refreshControl?.endRefreshing()
            self.movieTableView.reloadData()
        }
    }
    func tableRefreshCallback(refreshControl: UIRefreshControl) {
        reloadData(showHud: false, refreshControl: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = self.visibleMovies?.count ?? 0
        return numRows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieTableViewCell = movieTableView.dequeueReusableCellWithIdentifier("com.hacktoolkit.rottentomatoes.movieCell") as MovieTableViewCell
        let movie = self.visibleMovies[indexPath.row]
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
            self.visibleMovies = self.movies
        } else {
            self.visibleMovies = self.movies.filter {
                (movie: RottenTomatoesMovie) -> Bool in
                let rangeValue = (movie.title as NSString).rangeOfString(substring, options: NSStringCompareOptions.CaseInsensitiveSearch)
                let shouldInclude = rangeValue.location != NSNotFound
                return shouldInclude
            }
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

