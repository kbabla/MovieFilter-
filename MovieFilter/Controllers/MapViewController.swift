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
import SwiftyJSON
import Alamofire

class MapViewController: UIViewController, CLLocationManagerDelegate  {
    let OAUTH2_API_TWITTER = "https://api.twitter.com/oauth2/token"
    let TWITTER_API_KEY_SECRETKEY_COMBINED = "0k9nyU7iT92QuErdhjTEu1KaZ:57C4HyXDypoyvU6g6wOTgz3pEP0GnNudeIxCF5XloTHxi0ZMYl"
    let OUTH2_PARAMETERS : Parameters = ["grant_type" : "client_credentials"]
    var twitterAccessToken = " "

    
    @IBOutlet weak var mapView: MKMapView!
     let locationManager = CLLocationManager()
    
   
    
    //Map sizing and area properties
       let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    
     let model: movieDataModel = movieDataModel.singleton
    
    
    override func viewDidLoad() {
        let data = (TWITTER_API_KEY_SECRETKEY_COMBINED).data(using: String.Encoding.utf8)
        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let AUTHORIZATION_HEADER_ACCESS_TOKEN : HTTPHeaders = ["authorization" : "Basic " + base64, "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8." ]
        
                getTwitterAccessToken(url: OAUTH2_API_TWITTER, parameters: OUTH2_PARAMETERS , headers: AUTHORIZATION_HEADER_ACCESS_TOKEN)
        
        
        let start = Date()
         DispatchQueue.global(qos: .userInitiated).async {
            self.parseJSON()
        }
       
        
        
        
        super.viewDidLoad()
        let end = Date()
        print(end.timeIntervalSince(start))
        //conform to CLLocationMangerDelegate
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1000
        //privacy settings... set in info.plist.. Data Persistancy for App
        //Store if user has authorized use of location services.. stored as privacy- Location When in Use
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
    
        //allow for user location to appear
        //mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    

    
    func getTwitterAccessToken(url: String, parameters: Parameters, headers: HTTPHeaders){
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            
            response in
            if response.result.isSuccess{
                print("maybe worked?:")
            let data = JSON(response.data)
                print(data)
                
                self.saveAccessToken(data: data)
            }
            else{
               print("tested failed")
                print(response.error)
            }
        }
    }
    
    func saveAccessToken(data: JSON){
        twitterAccessToken = data["access_token"].string!
        print("withinFunction")
        print(twitterAccessToken)
        
        var data = (twitterAccessToken).data(using: String.Encoding.utf8)
        var base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let AUTHORIZATION_HEADER_GET_REQUEST : HTTPHeaders = ["Authorization":"Bearer " + twitterAccessToken]
        let TWITTER_API_GET = "https://api.twitter.com/1.1/search/tweets.json"
        var query = "Creed II"
        
       let base641 = data1!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        getTweets(url: TWITTER_API_GET, q: ["q" : query, "lang" : "en"], header: AUTHORIZATION_HEADER_GET_REQUEST)
        
        
    }
    
    func getTweets(url: String, q: [String:String], header: HTTPHeaders){
        
     

        Alamofire.request(url, method: .get, parameters: q, headers: header  ).responseJSON {
            response in
            if response.result.isSuccess{
                print("is success!")
                let data = JSON(response.data)
              print(data)
                
            }
            else{
                print(response.error)
            }
        }
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Setting up where the map is in terms of location and scale
        let location = locations.first
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
            //have list of nearby Locations
            
            //Placing pins onto map
            for index in 0...movieNearbyArray.count-1{
                //MKAnnotation class
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
    
   
    
    
    //parsingJSON-- load data in the intial view controller before Tableviews to avoid errors
    
    func parseJSON() -> Void {
        //JSON class from SwiftyJSON
        
            
        
        var json:JSON
        var data:Data
        let file = "https://api.themoviedb.org/3/discover/movie?primary_release_year=2018&page=1&include_video=false&include_adult=false&sort_by=popularity.desc&language=en-US&api_key=ed74e70274d657b728a1a2d317eef7bf"
        let url = URL(string: file)
        
        do{
           
            data = try Data(contentsOf: url!)
            
            json = try JSON(data: data)
            let decoder = JSONDecoder()
            //decoder.dataDecodingStrategy (for camel case)
            
            
        do{
            let todo = try decoder.decode(OverallDescription.self, from: data)
            model.addJSONData(data: todo)
            
        }
            
        catch{
            print(error)
        }
        }
        catch {
            print("fail")
            
        }
        
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
