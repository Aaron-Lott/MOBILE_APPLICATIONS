//
//  Fish.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 11/03/2021.
//

import SwiftUI

class Fish : ObservableObject {
    
    @Published var fishType = FishType.Fish1
    @Published var minutesTillRelease = 15
    
    func setType(type : FishType) {
        self.fishType = type;
        
        switch type {
        case FishType.Fish1:
            self.minutesTillRelease = 15
            break
        case FishType.Fish2:
            self.minutesTillRelease = 25
            break
        case FishType.Fish3:
            self.minutesTillRelease = 10
            break
        case FishType.Fish4:
            self.minutesTillRelease = 20
            break
        case FishType.Fish5:
            self.minutesTillRelease = 15
            break
        case FishType.Fish6:
            self.minutesTillRelease = 20
            break
        case FishType.Fish7:
            self.minutesTillRelease = 10
            break
        case FishType.Fish8:
            self.minutesTillRelease = 30
            break
        }
    }
}
