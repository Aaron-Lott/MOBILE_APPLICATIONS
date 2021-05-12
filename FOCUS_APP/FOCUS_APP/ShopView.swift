//
//  ShopView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 10/03/2021.
//

import SwiftUI

struct ShopView: View
{
    @ObservedObject var timerManager = TimerManager()
    @ObservedObject var fishInBowl = Fish()
    
    var body: some View
    {
        ZStack {
            //RoundedRectangle(cornerRadius: 10)
                //.fill(Color.white)
                //.frame(width: 80, height: 80)
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    
                        Button(action: {
                            changeFishToGrow(type: FishType.Fish1)
                        }) {
                            Image("\(FishType.Fish1)");
                        }
                    

                    Button(action: {
                        changeFishToGrow(type: FishType.Fish2)
                    }) {
                        Image("\(FishType.Fish2)");
                    }
                    Button(action: {
                        changeFishToGrow(type: FishType.Fish3)
                    }) {
                        Image("\(FishType.Fish3)");
                    }
                    Button(action: {
                        changeFishToGrow(type: FishType.Fish4)
                    }) {
                        Image("\(FishType.Fish4)");
                    }
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        changeFishToGrow(type: FishType.Fish5)
                    }) {
                        Image("\(FishType.Fish5)");
                    }
                    Button(action: {
                        changeFishToGrow(type: FishType.Fish6)
                    }) {
                        Image("\(FishType.Fish6)");
                    }
                    
                    Button(action: {
                        changeFishToGrow(type: FishType.Fish7)
                    }) {
                        Image("\(FishType.Fish7)");
                    }
                    Button(action: {
                        changeFishToGrow(type: FishType.Fish8)
                    }) {
                        Image("\(FishType.Fish8)");
                    }

                }
            }
        }
    }
    
    func changeFishToGrow(type: FishType)
    {
        if(!timerManager.timerActive && !timerManager.timerFinished)
        {
            self.fishInBowl.setType(type: type)
        }
    }
}
