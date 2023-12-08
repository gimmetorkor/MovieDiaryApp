//
//  MovieViewController.swift
//  MovieDiary
//
//  Created by imyourtk on 25/11/2566 BE.
//


import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showDate: UILabel!
    @IBOutlet weak var searchMovie: UISearchBar!
    
    
    var movieData = MovieData()
    var dateDiary: String = ""
    var searchResults: [Movie] = []



    override func viewDidLoad() {
        super.viewDidLoad()

        showDate.text = dateDiary

        movieData.loadFromDatabase()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
}
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.isEmpty ? movieData.movies.count : searchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = searchResults.isEmpty ? movieData.movies[indexPath.row] : searchResults[indexPath.row]
        
        cell.setup(with: movie)
        return cell
    }
    
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 330)
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movieData.movies[indexPath.row].title)
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        searchResults = movieData.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        collectionView.reloadData()
        
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchResults.removeAll()
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
           let vc = segue.destination as? RatingViewController {
            let selectedMovie = searchResults.isEmpty ? movieData.movies[selectedIndexPath.row] : searchResults[selectedIndexPath.row]
            vc.selectedMovie = selectedMovie
            vc.dateMovie = dateDiary
        }
    }

}
