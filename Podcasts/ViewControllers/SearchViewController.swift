//
//  SearchViewController.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/22/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet weak var barButton = UIBarButtonItem()
    
    var podcasts = [Podcast]()
    
    @IBAction func homeButton() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let playerViewController = storyboard.instantiateViewController(withIdentifier: "MainView")
        self.present(playerViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "searchTableCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! searchTableViewCell
        
        cell.titleLabel.text = podcasts[indexPath.row].collectionName
        cell.authorLabel.text = podcasts[indexPath.row].artistName
        
        if podcasts[indexPath.row].artworkURL30 != nil {
            let url = podcasts[indexPath.row].artworkURL30!
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.podcastImage?.image = UIImage(data: data)
                }
            }
        }
        // TODO - else

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        let detailVC = SearchDetailVC()
        detailVC.podcast = podcast
        detailVC.image = (tableView.cellForRow(at: indexPath) as! searchTableViewCell).podcastImage?.image
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
