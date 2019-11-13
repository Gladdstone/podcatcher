//
//  Podcast.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/11/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Podcast {
    
    dynamic var collectionId: String? = nil
    dynamic var collectionName: String = ""
    dynamic var artistName: String = ""
    dynamic var collectionViewUrl: URL
    dynamic var feedUrl: URL
    
    dynamic var artworkURL30: URL?
    dynamic var artworkURL60: URL?
    dynamic var artworkURL100: URL?
    dynamic var artworkURL600: URL?
    
    dynamic var smallImg: URL?
    dynamic var medImg: URL?
    dynamic var lrgImg: URL?
    
    dynamic var explicitness: String?
    
    dynamic var country: String?
    
    dynamic var primaryGenre: String?
    dynamic var genres: Array<String>?
    
    var episodes: Array<Episode>?
    
    // convenience
    init(collectionId: String?, collectionName: String, artistName: String, collectionViewUrl: URL, feedUrl: URL, artworkURL30: URL?, artworkURL60: URL?, artworkURL100: URL?, artworkURL600: URL?) {
//        self.init()
        
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.artistName = artistName
        self.collectionViewUrl = collectionViewUrl
        self.feedUrl = feedUrl
        
        if artworkURL30 != nil {
            self.artworkURL30 = artworkURL30
        }
        
        self.artworkURL60 = artworkURL60
        self.artworkURL100 = artworkURL100
        self.artworkURL600 = artworkURL600
    }
    
//    init(collectionId: String?, collectionName: String, artistName: String, collectionViewUrl: URL, feedUrl: URL, artworkURL30: URL, artworkURL60: URL, artworkURL100: URL, artworkURL600: URL, explicitness: String, country: String, primaryGenre: String, genres: Array<String>, episodes: Array<Episode>) {
//        self.collectionId = collectionId
//        self.collectionName = collectionName
//        self.artistName = artistName
//        self.collectionViewUrl = collectionViewUrl
//        self.feedUrl = feedUrl
//
//        self.artworkURL30 = artworkURL30
//        self.artworkURL60 = artworkURL60
//        self.artworkURL100 = artworkURL100
//        self.artworkURL600 = artworkURL600
//
//        self.explicitness = explicitness
//
//        self.country = country
//
//        self.primaryGenre = primaryGenre
//        self.genres = genres
//
//        self.episodes = episodes
//    }
    
}
