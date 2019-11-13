//
//  Episode.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/11/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation
import RealmSwift

class Episode {
    
    var title: String
    var subtitle: String?
    var link: URL
    var description: String?
    var date: Date?
    var duration: TimeInterval?
    
    init(title: String, subtitle: String?, link: URL, description: String?, date: Date?, duration: TimeInterval?) {
        self.title = title
        self.subtitle = subtitle
        self.link = link
        self.description = description
        self.date = date
        self.duration = duration
    }
    
}
