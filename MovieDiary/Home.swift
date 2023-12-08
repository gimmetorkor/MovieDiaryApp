//
//  Home.swift
//  MovieDiary
//
//  Created by imyourtk on 1/11/2566 BE.
//

import UIKit
import SwiftUI

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct Movies {
    var title: String
    var director: String
    var imageName: String
    var genre: String
    var releaseDate: String
    var precis: String
}




struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                 
                    ForEach(Array(Set(movies.map { $0.genre })), id: \.self) { genre in
                        Section(header:
                            Text(genre)
                                .foregroundColor(.yellow)
                                .font(.custom("Gill Sans", size: 20.0))
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        )
                        {
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(movies.filter { $0.genre == genre }, id: \.title) { movie in
                                        NavigationLink(destination: MovieDetail(movie: movie)) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Movie Diary")
                        .font(.custom("Gill Sans", size: 30.0))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .background(Color.black)
        }
    }
}


struct MovieCard: View {
    let movie: Movies

    var body: some View {
        VStack {
            Image(movie.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 300)

            Text(movie.title)
                .font(.custom("Gill Sans", size: 15.0))
                .bold()
                .foregroundColor(.white)
                .padding(.top, 5)

        }
        .frame(width: 150, height: 300)
        .padding()
        .cornerRadius(5)
    }
}


struct MovieDetail: View {
    let movie: Movies

    var body: some View {
        ScrollView {
            VStack {
                // Display the movie image
                Image(movie.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 450)
                    .cornerRadius(5)
//                    .padding()

                // Movie title
                Text(movie.title)
                    .font(.title)
//                    .padding()

                // Release date and director
                Text("\(movie.releaseDate) • Directed by \(movie.director)")
                    .font(.headline)
//                    .padding()

                // Synopsis
                Text(movie.precis)
                    .font(.none)
                    .padding()
            }
            .padding() // Add padding to the VStack to provide some spacing
        }
        .navigationTitle(movie.title)
//        .background(Color.black)
    }
}





class Home: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for: .normal)
        let contentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)
                
        // Add the UIHostingController's view as a subview to the current view
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
                
        // Set constraints for the SwiftUI view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
