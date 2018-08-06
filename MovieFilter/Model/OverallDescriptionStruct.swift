//
//  overallDescriptionStruct.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/4/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import Foundation
//struct used for decoding JSON data, contains an array of results from the results struct
struct OverallDescription: Decodable {
    let page: Int
    let total_results: Int
    var results: [results]
}
