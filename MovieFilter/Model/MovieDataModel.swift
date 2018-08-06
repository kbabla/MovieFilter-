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
    private var allMovies: [results]
    
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
        allMovies = [results]()
        //calling a parseJSON function in the init so that the singleton is init'd with the parsed data
       //parseJSON(success: forClosure(closureAction:closureScienceFiction:closureComedy:closureFamily:closureHorror:))
    }
    
    
 //function parses JSON data using Swift 4 Codable/Decodable feature.  Uses an escape clause add data into Singleton without falling out of scope or due to async behavior
    
    //below are set and get functions for pulling data into Discover and favorites view
    func numberOfAction() -> Int {
      return self.movieArrayAction.count
    }
    
    func numberOfSiFi() -> Int {
        return self.movieArrayScienceFiction.count
    }
    
    func numberOfFamily() -> Int {
        return self.movieArrayFamily.count
    }
    
    func numberOfHorror() -> Int {
        return self.movieArrayHorror.count
    }
    
    func numberOfComedy() -> Int {
        return self.movieArrayComedy.count
    }
    func numberOfAllMovies() -> Int {
        return self.allMovies.count
    }
    
    func movieTitle(Index: Int) -> String {
        var Title: String = " "
        if(Index < allMovies.count-1){
    Title = allMovies[Index].title
            
        }
        
        
        return Title
    }
    
    func movieGenre(Index: Int) -> String {
        
        if(Index < allMovies.count-1){
        guard let Genre = allMovies[Index].genreTitle else{return "No Genre"}
            return Genre
       
    }
        else{
            return "No Genre"
        }
        
    }

    
    func Subtitle(index: Int) -> String {
        return movieArrayAction[index].release_date
    }
    
    func getMovieFromArrayToFavorites(index: Int) -> Void {
        
        
        favoritesArray.append(allMovies[index])
        
    }
    
    func getFavorites(index: Int) -> results {
       return favoritesArray[index]
    }
    
    func favoriteSize() -> Int {
        return favoritesArray.count
    }
    private func addGenreName(name: String) -> Void {
        
        allMovies[allMovies.count-1].genreTitle = name
    }
    
    func addJSONData(data: OverallDescription) -> Void {
        var genreName: String = " "
        for index in 0...data.results.count-1{
            if data.results[index].genre_ids[0] == 28 {
            genreName = "Action"
            allMovies.append(data.results[index])
            addGenreName(name: genreName)
            }
            if data.results[index].genre_ids[0] ==  878{
                genreName = "Science Fiction"
                allMovies.append(data.results[index])
                addGenreName(name: genreName)
            }
            
            if data.results[index].genre_ids[0] ==  35{
                genreName = "Comedy"
                allMovies.append(data.results[index])
                 addGenreName(name: genreName)
            }
            if data.results[index].genre_ids[0] ==  10751{
                genreName = "Family"
                allMovies.append(data.results[index])
                 addGenreName(name: genreName)
            }
            if data.results[index].genre_ids[0] ==  27{
                genreName = "Horror"
                allMovies.append(data.results[index])
                 addGenreName(name: genreName)
            }
            
            print("size of allMovies array:")
            print(allMovies.count)
    
        }
        
        for index in 0...data.results.count-1{
            //print(todo.results[index].genre_ids[0])
            if data.results[index].genre_ids[0] == 28 {
                self.movieArrayAction.append(data.results[index])
                print("Closure and Action!")
                print(self.movieArrayAction.count)
            }
                //sorting my each chosen genre
            else if data.results[index].genre_ids[0] == 878{
                self.movieArrayScienceFiction.append(data.results[index])
                print("Number of SIFI Movies")
                print(self.movieArrayScienceFiction.count)
            }
                
            else if data.results[index].genre_ids[0] == 35{
                self.movieArrayComedy.append(data.results[index])
                print("Number of Comedy Movies")
                print(self.movieArrayComedy.count)
            }
                
            else if data.results[index].genre_ids[0] == 10751{
                self.movieArrayFamily.append(data.results[index])
                print("Number of Family Movies")
                print(self.movieArrayFamily.count)
            }
                
            else if data.results[index].genre_ids[0] == 27{
                self.movieArrayHorror.append(data.results[index])
                print("Number of Horror Movies")
                print(self.movieArrayHorror.count)
            }
        }
        
    }

    

}
