//
//  PlayerViewController.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/12/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                let menuViewController = storyboard.instantiateViewController(withIdentifier: "NavigationView")
                self.present(menuViewController, animated: true, completion: nil)
            case UISwipeGestureRecognizer.Direction.left:
                break
            default:
                break
            }
        }
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
