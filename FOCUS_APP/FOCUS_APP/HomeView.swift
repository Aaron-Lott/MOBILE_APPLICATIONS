//
//  HomeView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 08/03/2021.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var timerManager = TimerManager()
    @ObservedObject var fishInBowl = Fish()
    
    @ObservedObject var reef = Reef()
    
    @State private var modalActive = false;
    
    let timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()
    
    @State var messageIndex = 0;
    
    var messages = ["Focus!", "Keep going!", "Put down your phone.", "Leave me to grow in peace.", "You've got this!", "Breathe.", "I'm growing!", "Not bad, but you cod to better!", "You're nearly there.", "Look at you go!", "You're smashing this!", "Your fish has been released into the ocean, swipe up to visit it."]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 24) {
                
                if(!timerManager.timerFinished && timerManager.timerActive) {
                    Text(messages[messageIndex]).font(.custom("Roboto-Light", size: 18))
                        .foregroundColor(.white)
                        .offset(x: 0, y: -20)
                        .onReceive(timer) { time in
                            changeMessage()
                        }
                }
                
                
                ZStack {
                    
                    Image("FishBowl")
                        .colorMultiply(Color.cSand)
                    
                    let div = fishInBowl.minutesTillRelease > 0 ? fishInBowl.minutesTillRelease * 12: 1
                    
                    let frame = Int(timerManager.elapsedTime / div % 60)
                    
                    if frame < 5 {
                    Image("WaterFill\(frame)")
                            Image("\(fishInBowl.fishType)Egg")
                                .offset(y: 76)
                    } else {
                        Image("WaterFill5")
                            Image("\(fishInBowl.fishType)")
                                .offset(y: 30)
                    }
                }
                
                if(!timerManager.timerActive && !timerManager.timerFinished)
                {
                    Button(action: {
                        self.modalActive.toggle()
                    }) {
                        IconButton(label: "Edit", buttonColor: Color.cLightBlue, icon: "pencil.circle.fill")
                    }
                }
                
                    Text("\(timerManager.timeFormatted(startTime: self.fishInBowl.minutesTillRelease))")
                        .foregroundColor(.white)
                        .font(.custom("Roboto-Thin", size: 72))
                

                
                if(!timerManager.timerActive) {
                    if(!timerManager.timerFinished) {
                        Button(action: {
                            self.timerManager.start()
                        }) {
                            LargeButton(label: "Grow", buttonColor: Color.cLightBlue, shadowColor: Color.cDarkBlue)
                        }
                    } else {
                        Button(action: {
                            reef.ReleaseFish(type: fishInBowl.fishType)
                            timerManager.elapsedTime = 0
                            timerManager.timerFinished = false
                        }) {
                            LargeButton(label: "Release", buttonColor: Color.cLightBlue, shadowColor: Color.cDarkBlue)
                        }

                    }
                }
                else {
                    Button(action: {
                        self.timerManager.restTimer()
                    }) {
                        //LargeButton(label: "Give Up", buttonColor: Color.cRed, shadowColor: Color.cDarkRed)
                        
                        SmallButton(label: "Give Up")
                    }
                }
            }.offset(y: -20)
            
            ModalView(isShown: $modalActive, timerManager: timerManager, fishInBowl: fishInBowl) {Text(".").foregroundColor(Color.cOffWhite) }
        }
    }
    
    func changeMessage() {
        
        let chanceOfChange = Int.random(in: 0...9)
        
        if(!timerManager.timerFinished)
        {
            if(chanceOfChange == 0)
            {
                messageIndex = Int.random(in: 0...messages.count - 2)
            }
        }
    }
}
