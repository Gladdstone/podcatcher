//
//  PodcastList.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/29/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation

// TODO - update app to use shared instance in a way that makes best use of memory
class Podcasts {
    static var sharedInstance: Podcasts {
        struct Singleton {
            static let instance = Podcasts()
        }
        
        return Singleton.instance
    }
    
    var podcastList : [Podcast] = []
    
    func add(podcast: Podcast, at index: Int) {
        if podcastList.count >= index {
            podcastList.insert(podcast, at: index)
        } else {
            podcastList.append(podcast)
        }
    }
    
    func append(podcast: Podcast) {
        podcastList.append(podcast)
    }
    
    func deletePodcast(at index: Int) {
        podcastList.remove(at: index)
    }
}
