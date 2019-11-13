//
//  Search.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/11/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchService: NSObject, XMLParserDelegate {

    static let defaultSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    typealias JSONDictionary = [String: Any]
    
    static var podcasts: [Podcast] = []
    static var errorMessage = ""
    
    // TODO - implement these
    var limit = 50
    var lang = "en_us"
    var explicit = "Yes"    // TODO - user preferences for these values
    
    static func getSearchResults(searchTerm: String, completion: @escaping (([Podcast]?, String) -> Void)) {
        
        dataTask?.cancel()
        
        // TODO -: text validation https://github.com/adamwaite/Validator
        let validatedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "media=podcast&entity=podcast&term=\(validatedSearchTerm)"
            
            guard let url = urlComponents.url else { return }
            
            print("URL: \(url.absoluteString)")
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSearchResults(data)
                    
                    DispatchQueue.main.async {
                        completion(self.podcasts, self.errorMessage)
                    }
                }
            }
            
            dataTask?.resume()
        }
        
    }
    
    static func updateSearchResults(_ data: Data) {
        
        podcasts.removeAll()
        
        let json = try! JSON(data: data)
        
        if let podcastArray = json["results"].array {
            for podcastDic in podcastArray {
                let collectionId = podcastDic["collectionId"].string
                let collectionName = podcastDic["collectionName"].string
                let artistName = podcastDic["artistName"].string
                let collectionViewUrl = podcastDic["collectionViewUrl"].string
                let feedUrl = podcastDic["feedUrl"].string
                let artworkURL30 = podcastDic["artworkUrl30"].string
                let artworkURL60 = podcastDic["artworkUrl60"].string
                let artworkURL100 = podcastDic["artworkUrl100"].string
                let artworkURL600 = podcastDic["artworkUrl600"].string
                
                if(collectionName != nil && artistName != nil && collectionViewUrl != nil && feedUrl != nil && artworkURL30 != nil) {
                    let podcast = Podcast(collectionId: collectionId, collectionName: collectionName!, artistName: artistName!, collectionViewUrl: URL(string: collectionViewUrl!)!, feedUrl: URL(string: feedUrl!)!, artworkURL30: URL(string: artworkURL30!), artworkURL60: URL(string: artworkURL60!), artworkURL100: URL(string: artworkURL100!), artworkURL600: URL(string: artworkURL600!))
                    
                    podcasts.append(podcast)
                }
            }
        }
    }
    
}
