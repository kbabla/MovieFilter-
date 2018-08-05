//
//  movieDataModel.swift
//  MovieFilter
//
//  Created by Krishna Babla on 5/3/18.
//  Copyright © 2018 Krishna Babla. All rights reserved.
//

import Foundation

class movieDataModel{
    //will hold array by genre
    
    //example
    //genre id number
    //cooresponding Array
    
    //seperation of movies by genre..
    //28
    private var movieArrayAction: [results]
    //878
    private var movieArrayScienceFiction: [results]
    //35
    private var movieArrayComedy: [results]
    //10751
    private var movieArrayFamily: [results]
    //27
     private var movieArrayHorror: [results]
    
    
    //for favorites
    
    private var favoritesArray: [results]
    static var singleton = movieDataModel()
    
    

    
    init() {
        movieArrayAction = [results]()
        movieArrayScienceFiction = [results]()
        movieArrayComedy = [results]()
        movieArrayFamily = [results]()
        movieArrayHorror = [results]()
        favoritesArray = [results]()
        //calling a parseJSON function in the init so that the singleton is init'd with the parsed data
       parseJSON(success: forClosure(closureAction:closureScienceFiction:closureComedy:closureFamily:closureHorror:))
    }
    
    
 //function parses JSON data using Swift 4 Codable/Decodable feature.  Uses an escape clause add data into Singleton without falling out of scope or due to async behavior
    func parseJSON(success:@escaping ([results], [results], [results], [results], [results]) -> Void) -> Void {//closure to deal with async
        
        //API request is a list of movies sorted by current popularity, and release year in 2018 to get most relevant movies
        var request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?primary_release_year=2018&page=1&include_video=false&include_adult=false&sort_by=popularity.desc&language=en-US&api_key=ed74e70274d657b728a1a2d317eef7bf")! as URL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
             
                print(data)
            }
            
            let decoder = JSONDecoder()
            do {
                //takes the JSON data and using the decoder/codable aspects of Swift 4, maps to my Overall Discription Struct, and the internal array of results.  Key value terms match with the JSON data so that info parses properly
                let todo = try decoder.decode(OverallDescription.self, from: data!)
                
               // DispatchQueue.main.async{
                print(todo.total_results)
                print(todo.results[0].overview)
                print(todo.results.count)
                
                    for index in 0...todo.results.count-1{
                        print(todo.results[index].genre_ids[0])
                        if todo.results[index].genre_ids[0] == 28 {
                            self.movieArrayAction.append(todo.results[index])
                            print("Closure and Action!")
                        }
                            //sorting my each chosen genre
                        else if todo.results[index].genre_ids[0] == 878{
                            self.movieArrayScienceFiction.append(todo.results[index])
                            print("Number of Action Movies")
                        }
                            
                        else if todo.results[index].genre_ids[0] == 35{
                            self.movieArrayComedy.append(todo.results[index])
                            print("Number of Action Movies")
                        }
                            
                        else if todo.results[index].genre_ids[0] == 10751{
                            self.movieArrayFamily.append(todo.results[index])
                            print("Number of Action Movies")
                        }
                            
                        else if todo.results[index].genre_ids[0] == 27{
                            self.movieArrayHorror.append(todo.results[index])
                            print("Number of Action Movies")
                        }
                    }
                   
                //completionHandler(todo, nil)
            //}
                print("below is the number of Action movies in the array after the Async")
                print(self.movieArrayAction.count)
                
                //calling escape so that data ends up in Singleton
                success(self.movieArrayAction, self.movieArrayScienceFiction, self.movieArrayComedy, self.movieArrayFamily, self.movieArrayHorror)
                
                print("below is the number of Action movies in the array after the Closure")
                print(self.movieArrayAction.count)
            }catch {
                print("error trying to convert data to JSON")
                print(error)
                //completionHandler(nil, error)
            }
            
            
        })
        
        dataTask.resume()
 
    }
    //Add to model while JSON parse
    func forClosure(closureAction: [results], closureScienceFiction: [results], closureComedy: [results], closureFamily: [results], closureHorror: [results]) -> Void {
        print("Closure Called!")
        
        self.movieArrayAction = closureAction
        self.movieArrayScienceFiction = closureScienceFiction
       self.movieArrayComedy = closureComedy
        self.movieArrayFamily = closureFamily
        self.movieArrayHorror = closureHorror

    }
    
    //below are set and get functions for pulling data into Discover and favorites view
    func numberOfAction() -> Int {
      return self.movieArrayAction.count
    }
    
    func movieTitle(random: Int) -> String {
        var Title: String = " "
        if(random < movieArrayAction.count-1){
    Title = movieArrayAction[random].title
            
        }
        
        
        return Title
    }
    
    func Subtitle(random: Int) -> String {
        return movieArrayAction[random].release_date
    }
    
    func getMovieFromArrayToFavorites(index: Int) -> Void {
        
        
        favoritesArray.append(movieArrayAction[index])
        
    }
    
    func getFavorites(index: Int) -> results {
       return favoritesArray[index]
    }
    
    func favoriteSize() -> Int {
        return favoritesArray.count
    }
    

    

}
