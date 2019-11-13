//
//  SearchDetailVC.swift
//  Podcasts
//
//  Created by Joe Farrell on 12/3/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import UIKit
import PureLayout
import RealmSwift


class SearchDetailView: UIView, UITableViewDelegate, UITableViewDataSource {

    var subscribed = SubscribeList.sharedInstance.podcasts
    
    var podcast: Podcast?
    var episodes: [Episode] = []
    var xmlService: XMLService?
    var image: UIImage?
    var subBool = false
    
    var shouldSetupConstraints = true
    
    var bannerView: UIImageView!
    var profileView: UIImageView!
    var titleLabel: UILabel!
    var authorLabel: UILabel!
    var descriptionLabel: UILabel!
    var subButton: UIButton!
    var tableView: UITableView!
    
    let screenSize = UIScreen.main.bounds
    
    
    init(frame: CGRect, podcast: Podcast?, image: UIImage?) {
        
        super.init(frame: frame)
        
        self.podcast = podcast
        self.image = image
        
        // Begin asynchronous function of retrieving episode list
        self.xmlService = XMLService()
        self.xmlService!.startParsingXML(feedURL: (podcast?.feedUrl)!, completion: episodeCallback)
        
        // Optional banner image (defaults to app orange)
        bannerView = UIImageView(frame: CGRect.zero)
//        bannerView.image = self.image!
        bannerView.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        bannerView.autoSetDimension(.height, toSize: screenSize.width / 3)
        
        self.addSubview(bannerView)
        
        // Podcast image
        profileView = UIImageView(frame: CGRect.zero)
        let url = self.podcast?.artworkURL100
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let img = UIImage(data: data!) {
                    self.profileView.image = img
                }
            }
        }).resume()
        profileView.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        profileView.layer.borderColor = UIColor.white.cgColor
        profileView.layer.borderWidth = 1.0
        profileView.layer.cornerRadius = 5.0
        profileView.autoSetDimension(.width, toSize: 124.0)
        profileView.autoSetDimension(.height, toSize: 124.0)
        
        self.addSubview(profileView)
        
        // Podcast title label
        titleLabel = UILabel()
        titleLabel.text = self.podcast?.collectionName
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel.numberOfLines = 0
        titleLabel.preferredMaxLayoutWidth = 200
        
        self.addSubview(titleLabel)
        
        // Author
        authorLabel = UILabel()
        authorLabel.text = self.podcast?.artistName
        authorLabel.font = UIFont(name: authorLabel.font.fontName, size: 15)
        authorLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        authorLabel.numberOfLines = 1
        
        self.addSubview(authorLabel)
        
        // Podcast description label
        descriptionLabel = UILabel()
        descriptionLabel.text = "Coming soon"
        descriptionLabel.font = UIFont(name: authorLabel.font.fontName, size: 15)
        descriptionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        descriptionLabel.numberOfLines = 0
        
        self.addSubview(descriptionLabel)
        
        // Subscription button
        subButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
        subButton.setTitle("Subscribe", for: .normal)
        subButton.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        
        // TODO - if already subscribed, button is deactivated
        for pod in self.subscribed {
            if(pod.collectionName == self.podcast?.collectionName) {
                subBool = true
            }
        }
        
        if !subBool {
            subButton.addTarget(self, action: #selector(self.subscribe), for: .touchUpInside)
        }
        
        self.addSubview(subButton)
        
        // Scrolling episode select
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        self.addSubview(tableView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Handles autolayout constraints
    */
    override func updateConstraints() {
        
        if(shouldSetupConstraints) {
            let edgesInset: CGFloat = 10.0
            let centerOffset: CGFloat = 62.0
            
            // pin the banner to the top of the screen
            bannerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            
            // pin profile to left of the screen and bottom of the banner
            profileView.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInset)
            profileView.autoPinEdge(.bottom, to: .bottom, of: bannerView, withOffset: centerOffset)
            
            // pin title to right of the screen and bottom of the banner
            titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
            titleLabel.autoPinEdge(.bottom, to: .bottom, of: bannerView, withOffset: centerOffset)
            
            authorLabel.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
            authorLabel.autoPinEdge(.bottom, to: .bottom, of: titleLabel, withOffset: centerOffset)
            
            descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
            descriptionLabel.autoPinEdge(.bottom, to: .bottom, of: authorLabel, withOffset: centerOffset)
            
            subButton.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
            subButton.autoPinEdge(.bottom, to: .bottom, of: descriptionLabel, withOffset: centerOffset)
            
            tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: edgesInset)
            tableView.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInset)
            tableView.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInset)
            tableView.autoPinEdge(.top, to: .bottom, of: subButton, withOffset: centerOffset)
            
            shouldSetupConstraints = false
        }
        
        super.updateConstraints()
        
    }
    
    @objc func subscribe() {
        if self.podcast != nil {
            subscribed.append(self.podcast!)
            
//            let realm = try! Realm()
//
//            try! realm.write {
//                realm.add(self.podcast!)
//            }
            
            print("subscription successful")
        }
        // TODO - else error notification
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /**
     Callback function for XMLService
     - Parameter flag: true on success
     - ToDo: either make asynchronous or move to its own thread
    */
    func episodeCallback(flag: Bool) {
        print("Episode list callback complete")
        if flag {
            let data = xmlService?.parsedData
            
            for ep in data! {
                let title = ep["title"]
                let subtitle = ep["subtitle"]
                if ep["link"] == nil {
                    continue
                }
                let link = URL(string: ep["link"]!)
                let description = ep["description"]
                // TODO
//                let date = ep["pubDate"]
//                let duration = TimeInterval(ep["itunes:duration"])
                
                let episode = Episode(title: title!, subtitle: subtitle, link: link!, description: description, date: nil, duration: nil)
                
                episodes.append(episode)
            }   // end for
        }   // end if
    }
    
    // MARK: - Table View data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        switch indexPath.section {
        case 0:
            //            cell.textLabel!.text = "\(indexPath.row)"
            //        case 1:
            cell.textLabel!.text = episodes[indexPath.row].title
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        
        if AudioService.getPlaying() {
            AudioService.toggleStream()
        } else {
            AudioService.streamFile(from: episode.link)
        }
    }

}
