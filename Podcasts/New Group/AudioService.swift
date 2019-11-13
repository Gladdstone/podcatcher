//
//  ImageService.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/30/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation
import AVFoundation

class AudioService {
    
    private static let defaultSession = URLSession(configuration: .default)
    private static var dataTask: URLSessionDataTask?
    
    private static var player: AVPlayer?
    private static var playing: Bool = false
    private static var paused: Bool = false
    
    static func getFile(from: URL) {
        self.dataTask?.cancel()
    }
    
    private static func pauseStream() {
        player?.pause()
    }
    
    private static func resumeStream() {
        player?.play()
    }
    
    static func toggleStream() {
        if playing && paused {
            resumeStream()
            paused = !paused
        } else if playing && !paused {
            pauseStream()
            paused = !paused
        }
    }
    
    static func streamFile(from: URL) {
        let playerItem = AVPlayerItem.init(url: from)

        self.player = AVPlayer.init(playerItem: playerItem)
        self.player?.play()
        self.playing = true
    }
    
    // MARK: - Mutators/Accessors
    static func getPlaying() -> Bool {
        return self.playing
    }
    
}
