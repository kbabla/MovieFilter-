//
//  MapViewController.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/3/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit




class MapViewController: UIViewController, CLLocationManagerDelegate  {

    @IBOutlet weak var mapView: MKMapView!
     let locationManager = CLLocationManager()
    
   
    
    //Map sizing and area properties
       let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    
    override func viewDidLoad() {
         let model: movieDataModel = movieDataModel.singleton
        super.viewDidLoad()
        //conform to CLLocationMangerDelegate
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1000
        //privacy settings... set in info.plist.. Data Persistancy for App
        //Store if user has authorized use of location services.. stored as privacy- Location When in Use
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
    
        //allow for user location to appear
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Setting up where the map is in terms of location and scale
        let location = locations.first
        print(location?.coordinate)
        let center = location?.coordinate
  
        let region = MKCoordinateRegion(center: center!, span: span)
      
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        //Search for nearby Movie Theatres
        let movieTheatreLocations =  MKLocalSearchRequest()
        movieTheatreLocations.naturalLanguageQuery = "Movie Theaters"
        movieTheatreLocations.region = region
        let request = MKLocalSearch(request: movieTheatreLocations)
        
        //get list of search results
        request.start { (response, _) in
            guard let response = response else {return}
             let movieNearbyArray = response.mapItems
//            self.nearByMovieTheatres = movieNearbyArray
            //have list of nearby Locations
            
            for index in 0...movieNearbyArray.count-1{
                let pin: mapPin = mapPin(title: movieNearbyArray[index].name!, subtitle: " ", coordinate: movieNearbyArray[index].placemark.coordinate)
                
                self.mapView.addAnnotation(pin)
            }
            
        }
        
        //turn off location tracking to save battery
        locationManager.stopUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON() -> Void {
        <#function body#>
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
