//
//  MoviesTabItemViewController.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/16/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class MoviesTabItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var moviesTabBarController = self.parentViewController?.tabBarController
        var tabBarItemTitle = self.tabBarItem.title!
        var moviesViewController = segue.destinationViewController as MoviesViewController
        var movieType = tabBarItemTitle == "Movies" ? RottenTomatoesApiMovieType.Movies : RottenTomatoesApiMovieType.DVDs
        moviesViewController.setMovieType(movieType)
    }
}
