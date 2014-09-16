//
//  MovieTableViewCell.swift
//  rottentomatoes
//
//  Created by Jonathan Tsai on 9/14/14.
//  Copyright (c) 2014 Hacktoolkit. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailPosterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!

    var movie: RottenTomatoesMovie?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func formatWithMovie(movie: RottenTomatoesMovie) {
        self.movie = movie

        var attributes = [NSFontAttributeName : UIFont.boldSystemFontOfSize(13.0)]
        var formattedSynopsis = NSMutableAttributedString(string: "\(movie.mpaaRating) ", attributes: attributes)
        formattedSynopsis.appendAttributedString(NSMutableAttributedString(string: "\(movie.synopsis)"))
        self.titleLabel.text = movie.title
        self.synopsisLabel.attributedText = formattedSynopsis
        self.thumbnailPosterImage.setImageWithURL(NSURL(string: movie.thumbnailPosterUrl))
        self.thumbnailPosterImage.alpha = 0
        UIView.animateWithDuration(0.3, animations: {
            self.thumbnailPosterImage.alpha = 1
        })
    }

}
