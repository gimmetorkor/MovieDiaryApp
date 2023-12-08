//
//  RatingViewController.swift
//  MovieDiary
//
//  Created by imyourtk on 29/11/2566 BE.
//

import UIKit

class RatingViewController: UIViewController {
    
    var selectedMovie: Movie?
    var dateMovie: String = ""
    
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var lbDirectorName: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var imgRating: UIImageView!
    
    func showImg(){
        if let movie = selectedMovie {
            imgRating.image = UIImage(named: movie.image)
            movieName.text = selectedMovie?.title
            lbDirectorName.text = selectedMovie?.director
        } else {
            imgRating.image = UIImage(named: "defaultImage")
        }
    }
    func showDetail() {
        if let movie = selectedMovie {
            movieName.text = movie.title
            lbDetail.text = "\(movie.releaseDate) • Directed by"
            lbDirectorName.text = movie.director
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showImg()
        showDetail()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? Diary {
                vc.selectedMovie = selectedMovie
                vc.dateDiary = dateMovie
            }
        }
    
}
