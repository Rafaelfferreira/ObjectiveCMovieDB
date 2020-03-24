//
//  PopularMoviesTableViewCell.swift
//  MovieDBViper
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
