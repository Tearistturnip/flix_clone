//
//  MovieCell.swift
//  flix_clone
//
//  Created by Justin Lee on 1/30/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie!{
        didSet {
            titleLabel.text = movie?.title
            overviewLabel.text = movie?.overview
            let posterURL = movie?.posterUrl
            posterImageView.af_setImage(withURL: posterURL!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
