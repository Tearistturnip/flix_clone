//
//  Movie.swift
//  flix_clone
//
//  Created by Justin Lee on 2/28/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import Foundation

class Movie {
    let basURLString = "https://image.tmdb.org/t/p/w500"
    var posterUrl: URL?
    var backdropUrl: URL?
    var title: String
    var overview: String
    var releaseDate: String
    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        let posterPath = dictionary["poster_path"] as? String
        posterUrl = URL(string: basURLString + posterPath!)
        let backdropPath = dictionary["backdrop_path"] as? String
        backdropUrl = URL(string: backdropPath! + posterPath!)
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        // Set the rest of the properties
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
}
