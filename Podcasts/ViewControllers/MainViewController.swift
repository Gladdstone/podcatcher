//
//  ViewController.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/12/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import UIKit
import SwiftyJSON
import Realm
import RealmSwift

class MainViewController: UIViewController, UISearchBarDelegate {
    
    var podcasts = Podcasts.sharedInstance.podcastList
    var subscribed = SubscribeList.sharedInstance.podcasts
    
    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var playButton: UIButton!
//    @IBOutlet weak var playLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // TODO - retrieve podcasts from Realm DB and reassemble subscription list
//        let realm = try! Realm()
//
//        let results = realm.objects(Podcast.self)
        
//        print("SUBSCRIBED COUNT: \(results.count)")
        
        // TODO - testing purposes
        print("SUBSCRIBED LIST")
        for pod in self.subscribed {
            print(pod.collectionName)
        }
        
//        playLabel.text = ""
//        updatePlayView()
        
        // TODO - TESTING PURPOSES ONLY
//        let audioURL = URL(string: "http://www.podtrac.com/pts/redirect.mp3/feeds.soundcloud.com/stream/543982782-scott-johnson-27-tms-1614-side-of-undies.mp3")
//        AudioService.streamFile(from: audioURL!)
//
//        updatePlayView()
        // TODO - END TESTING PURPOSES
        
        // Set swipe gesture navigation
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    /**
     Handles left and right swipe to new views.
     - Parameter gesture: left or right swipe
     */
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuView")
                self.present(menuViewController, animated: false, completion: nil)
            case UISwipeGestureRecognizer.Direction.left:
                let playerViewController = storyboard.instantiateViewController(withIdentifier: "PlayerView")
                self.present(playerViewController, animated:false, completion:nil)
            default:
                break
            }
        }
    }
    
    /**
     Sends queries iTunes Store API against user input with checks for podcast media only. Pushes response to SearchViewController as array of Podcast objects.
     - Parameter searchBar: UISearchBar object
    **/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        resignFirstResponder()
        
        let searchTerm = searchBar.text
        
        if searchTerm == nil {
            return
        }
        
        SearchService.getSearchResults(searchTerm: searchTerm!, completion: { results, errorMessage in
            if let results = results {
                for res in results {
                    self.podcasts.append(res)
                }
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                let searchTableNav = storyboard.instantiateViewController(withIdentifier: "SearchTableNav") as! NavigationViewController
                
                let searchVC = searchTableNav.viewControllers.first as! SearchViewController
                searchVC.podcasts = self.podcasts
                
                self.present(searchTableNav, animated:false, completion:nil)
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        })
    }
    
    /**
     Helper function for refreshing play/pause button image as appropriate
    */
//    func updatePlayView() {
//        let imageURL: URL
//        if AudioService.getPlaying() {
//            imageURL = URL(fileURLWithPath: "Assets").appendingPathComponent("pause_black.png")
//        } else {
//            imageURL = URL(fileURLWithPath: "Assets").appendingPathComponent("play_black.png")
//        }
//
//        let image = UIImage(contentsOfFile: imageURL.path)
//        playButton.imageView?.image = image
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchViewController {
            vc.podcasts = self.podcasts
        }
    }

}

