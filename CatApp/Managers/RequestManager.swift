//
//  RequestManager.swift
//  CatApp
//
//  Created by Tom Pruimboom on 29/05/2019.
//  Copyright © 2019 Tom Pruimboom. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RequestManager {
    
    static func getCatGif( result:@escaping (_:[Dictionary<String, Any>]) -> Void) {
        
        let APIKey = "bd25b446-84e7-4a33-94c4-1829dcb2e6fd"
        let headers = [ "x-api-key" : "\(APIKey)"]
        let url = "https://api.thecatapi.com/v1/images/search?limit=100&mime_types=gif"
        
        var catGifDict = [Dictionary<String, Any>] ()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success( _):
                guard let json = response.result.value as?  [Dictionary<String, Any>] else {return}
                print ("JSON response: \(json)")
                catGifDict = json
            case .failure(let error):
                print("error \(error)")
            }
            result(catGifDict)
        }
    }
    
    static func imageGet( result:@escaping (_:NSDictionary) -> Void) {
        
        let APIKey =  "563492ad6f91700001000001cf1d8b8f3c1346d28ac42b8f10c15729"
        let url = "https://api.pexels.com/v1/curated?per_page=30&page=1"
        let headers = [
            "Authorization": "\(APIKey)"
            ]
        
        var imageDict = NSDictionary()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                switch response.result{
                case .success( _):
                    let json = response.result.value as! NSDictionary
                    print("response \(json)")
                    imageDict = json
                    print("response \(json)")
                case .failure(let error):
                    print("error \(error)")
                }
                result(imageDict)
        }
    }
    

    static func searchImage(searchString: String, result:@escaping (_:NSDictionary) -> Void) {
        
        let searchString = searchString
        let APIKey =  "563492ad6f91700001000001cf1d8b8f3c1346d28ac42b8f10c15729"
        let url = "https://api.pexels.com/v1/search?query=\(searchString)&per_page=30&page=1"
        let headers = [
            "Authorization": "\(APIKey)"
            ]
        
        var imageDict = NSDictionary()
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                switch response.result{
                case .success( _):
                    let json = response.result.value as! NSDictionary
                    print("response \(json)")
                    imageDict = json
                    print("response \(json)")
                case .failure(let error):
                    print("error \(error)")
                }
            result(imageDict)
        }
    }
    
    
    static func getText( result:@escaping (_:String) -> Void){
        let url = "https://loripsum.net/api"
        var thisText = String()
        
        Alamofire.request(url, method:  .get, parameters: nil).response { response in
            if let data = response.data, let text = String(data: data, encoding: .utf8) {
                print("Data: \(text)")
                thisText = text
                result(thisText)
            }
        } 
    }
}
