//
//  PodcastList.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/29/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation
import RealmSwift

// Designer's note: this should really be a dictionary to allow for O(1) lookup time but there's no
// immediately apparent key. Requires further thought.
class SubscribeList: Object {
    
    static var sharedInstance: SubscribeList {
        struct Singleton: Codable {
            static let instance = SubscribeList()
        }
        
        return Singleton.instance
    }
    
    var podcasts : [Podcast] = []
//    var podcasts: [String: Podcast] = [:]
    
    func append(podcast: Podcast) {
        podcasts.append(podcast)
    }
    
    func deletePodcast(at index: Int) {
        podcasts.remove(at: index)
    }
    
}
