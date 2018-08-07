//
//  resultsStut.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/3/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import Foundation

//struct used for decoding JSON data
struct results:Decodable {
    let title: String
    let overview: String
    let release_date: String
    let genre_ids: Array<Int>
    let poster_path: String
    var genreTitle: String?
    
}
