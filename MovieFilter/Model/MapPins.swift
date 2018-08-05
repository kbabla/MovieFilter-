//
//  mapPins.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/4/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

//Class used for the Maps view.  holds the relevant information for an MKAnnotation, which is essentially a pin drop on the map with the relevant data like location, name, etc.
import Foundation
import MapKit
//class for pin annonation!
class mapPin : NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
       self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
