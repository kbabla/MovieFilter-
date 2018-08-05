//
//  movieClass.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/3/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import Foundation

//class that will hold information for an individual movie!
class movie: Codable{
    //variable that are recieved from theMovieDB api
    var page: Int
    var total_results: Int
    var total_pages: Int
  
    
    //array of Results objects called results

    //var results
         var title: String
         var overview: String
        var release_date: String
         var genre_ids: Array<Int>
         var poster_path: String
    
  
    
   
    
    
    init(title: String, overview: String, release_date: String, genre_ids: Array<Int>, poster_path: String) {
        self.title = title
        self.overview = overview
        self.release_date = release_date
        self.genre_ids = genre_ids
        self.poster_path = poster_path
        self.page = 1
        self.total_results = 1
        self.total_pages = 1
//        results = [String: Any]()
//        results = [title:(Any).self]
     
        
        
//        results.init(title: title, overview: overview, release_date: release_date, genre_ids: genre_ids, poster_path: poster_path)
    }
    
    
}
