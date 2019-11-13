//
//  MenuViewController.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/13/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                break
            case UISwipeGestureRecognizer.Direction.left:
                let playerViewController = storyboard.instantiateViewController(withIdentifier: "NavigationView")
                self.present(playerViewController, animated:true, completion:nil)
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
