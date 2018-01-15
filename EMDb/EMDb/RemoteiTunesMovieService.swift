//
//  RemoteiTunesMovieService.swift
//  EMDb
//
//  Created by Roger Florat on 15/01/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RemoteiTunesMovieService {

    func getTopMovies(completionHandler: @escaping ([[String: String]]?) -> Void) {
        
        let url = URL(string: "https://itunes.apple.com/es/rss/topmovies/limit=99/json")!
        
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                
                if let value = response.result.value {
                    
                    let  json = JSON(value)
                    
                    var result = [[String: String]]()
                    
                    let entries = json["feed"]["entry"].arrayValue
                    
                    for entry in entries {
                        var movie = [String: String]()
                        
                        movie["id"] = entry["id"]["attributes"]["im:id"].stringValue
                        movie["title"] = entry["im:id"]["label"].stringValue
                        movie["summary"] = entry["summary"]["label"].stringValue
                        movie["image"] = entry["im:image"][0]["label"].stringValue
                        .replacingOccurrences(of: "60x60", with: "500x500")
                        movie["category"] = entry["category"]["attributes"]["label"].stringValue
                        movie["director"] = entry["im:artist"]["label"].stringValue
                        
                        result.append(movie)
                    }
                    
                 completionHandler(result)
                    
                }
                
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
        }
        
    }
    
    func searchMovies(byTerm: String, completionHandler: @escaping ([[String: String]]?) -> Void)   {
      
         let url = URL(string: "https://itunes.apple.com/search")!
        
        Alamofire.request(url, method: .get, parameters: ["media": "movie", "country":"es", "attribute":"movieTerm", "term":"\(byTerm)"], encoding: URLEncoding.default, headers: nil).validate().responseJSON {
            (response) in
            
            switch response.result {
            case .success:
                var result = [[String: String]]()
                
                if let value = response.result.value {
                    
                    let  json = JSON(value)
                    
                    let entries = json["results"].arrayValue
                    
                    for entry in entries {
                        var movie = [String: String]()
                        movie["id"] = entry["trakId"].stringValue
                        movie["title"] =  entry["trakName"].stringValue
                        movie["summary"] = entry["longDescription"].stringValue
                        movie["image"] = entry["artworkUrl100"].stringValue.replacingOccurrences(of: "100x100", with: "500x500")
                        movie["category"] = entry["primaryGenreName"].stringValue
                        movie["director"] = entry["astisName"].stringValue
                        
                        result.append(movie)
                    }
                    
                }
                
                completionHandler(result)
                
            case .failure(let error):
                print(error)
                completionHandler(nil)
            }
            
            
        }
    }
    
}
