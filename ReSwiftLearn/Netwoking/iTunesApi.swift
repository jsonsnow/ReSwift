//
//  iTunesApi.swift
//  ReSwiftLearn
//
//  Created by chen liang on 2018/10/18.
//  Copyright © 2018年 chen liang. All rights reserved.
//

import Foundation

final class ItunesApi {
    static func searchFor(category:String, completion:@escaping ([String]) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(category)media=music"
        let urlRequest:URLRequest = URLRequest.init(url: URL.init(string: urlString)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion([])
                return
            }
            do {
                let strings = try ItunesApi.parseResponseToImageUrls(data!)
                DispatchQueue.main.async {
                    completion(strings)
                }
            } catch {
                fatalError("xxx")
            }
        }
        task.resume()
    }
    
    static func parseResponseToImageUrls(_ responseData: Data) throws -> [String] {
        let dictionary = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject]
        let array = dictionary?["results"] as? [[String: AnyObject]]
        
        let strings = array!.map { (dictionary) -> String in
            return dictionary["artworkUrl100"] as! String
        }
        
        return strings
    }
}
