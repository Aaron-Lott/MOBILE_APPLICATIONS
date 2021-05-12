//
//  ViewController.swift
//  MOBILE-APPLICATIONS
//
//  Created by Aaron Lott on 05/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var growButton: UIButton!
    
    var timer: Timer!
    var seconds = 0
    var minutes = 0
    
    var timerIsActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up;
        self.view.addGestureRecognizer(swipeUp)
        
        growButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
    }
    
    @objc func swipeAction(swipe:UISwipeGestureRecognizer)
    {
        performSegue(withIdentifier: "goDown", sender: self)
    }
    
    @objc func startTimer()
    {
        if !timerIsActive
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementTimerLabel), userInfo: nil, repeats: true)
            
            growButton.isHidden = true;
            
            timerIsActive = true;
        }
    }

    
    @objc func incrementTimerLabel()
    {
        seconds += 1
        
        if(seconds >= 60) {
            minutes += 1
            seconds = 0
        }
        
        timerLabel.text = (minutes < 10 ? "0" + String(minutes) : String(minutes)) + ":"
            + (seconds < 10 ? "0" + String(seconds) : String(seconds));
    }
    
    @IBAction func unwindToMainVC(segue:UIStoryboardSegue) { }
}


