//
//  TimerManager.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 08/03/2021.
//

import SwiftUI

class TimerManager: ObservableObject {
    
    var timer: Timer? = Timer()
    
    @Published var elapsedTime = 0;
    
    var timerActive = false;
    @Published var timerFinished = false;
    
    func start() {
        if(self.timer == nil)
        {
            self.timerActive = true;
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.elapsedTime += 1 }
        }
}
    
    func timeFormatted(startTime: Int) -> String {
        let time = (startTime * 60) - self.elapsedTime
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if(time <= 0 && timerActive)
        {
            stopTimer()
            self.timerFinished = true
            self.timerActive = false
        }
        
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    func restTimer() {
        elapsedTime = 0
        stopTimer()
        timerActive = false
    }
    
    
    func stopTimer()
    {
        if self.timer != nil {
            self.timer!.invalidate()
            timer = nil
      }
    }
}
