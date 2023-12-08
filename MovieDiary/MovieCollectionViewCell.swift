//
//  MovieCollectionViewCell.swift
//  CollectionViews
//
//  Created by Emmanuel Okwara on 28/06/2020.
//  Copyright © 2020 Macco. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var lbDirector: UILabel!
    
    @IBOutlet weak var lbYear: UILabel!
    
    func setup(with movie: Movie) {
        if let image = UIImage(named: movie.image) {
            movieImageView.image = image
        }
        titleLbl.text = movie.title
        lbDirector.text = "directed by \(movie.director)"
        lbYear.text = "(\(movie.releaseDate))"
    }
    
    

}

