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


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func formatWithMovieDataDictionary(movieDictionary: NSDictionary) {

        let title = movieDictionary["title"] as NSString
        let mpaaRating = movieDictionary["mpaa_rating"] as NSString
        let synopsis = movieDictionary["synopsis"] as NSString
        let posters = movieDictionary["posters"] as NSDictionary
        let thumbnailUrl = posters["thumbnail"] as NSString

        var attributes = [NSFontAttributeName : UIFont.boldSystemFontOfSize(13.0)]

        var formattedSynopsis = NSMutableAttributedString(string: "\(mpaaRating) ", attributes: attributes)
        formattedSynopsis.appendAttributedString(NSMutableAttributedString(string: "\(synopsis)"))
        self.titleLabel.text = title
        self.synopsisLabel.attributedText = formattedSynopsis
        self.thumbnailPosterImage.setImageWithURL(NSURL(string: thumbnailUrl))
    }

}
