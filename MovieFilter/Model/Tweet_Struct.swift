//
//  Tweet_Struct.swift
//  MovieFilter
//
//  Created by Krishna Babla on 12/6/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import Foundation

struct statuses : Codable {
    var text : String?
}

struct Tweet: Codable {
    var statuses : [statuses]?
}
