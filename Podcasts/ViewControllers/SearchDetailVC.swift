//
//  SearchDetailVC.swift
//  Podcasts
//
//  Created by Joe Farrell on 12/3/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import UIKit

class SearchDetailVC: UIViewController {
    
    var searchDetailView: SearchDetailView!
    
    var podcast: Podcast?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDetailView = SearchDetailView(frame: CGRect.zero, podcast: self.podcast, image: self.image)
        self.view.addSubview(searchDetailView)
        
        searchDetailView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadEpisode(episode: Episode) {
        print("load episode")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
