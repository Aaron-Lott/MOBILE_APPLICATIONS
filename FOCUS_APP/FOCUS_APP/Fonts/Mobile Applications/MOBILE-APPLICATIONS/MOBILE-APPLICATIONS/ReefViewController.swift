//
//  ReefViewController.swift
//  MOBILE-APPLICATIONS
//
//  Created by Aaron Lott on 07/03/2021.
//

import UIKit

class ReefViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down;
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeAction(swipe:UISwipeGestureRecognizer)
    {
        performSegue(withIdentifier: "unwindSegueToMainVC", sender: self)
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
