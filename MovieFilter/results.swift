//
//  results.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/3/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import Foundation
class results: Codable{
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
        
    }
    
}
