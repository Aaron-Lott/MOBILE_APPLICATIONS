//
//  BaseView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 19/03/2021.
//

import SwiftUI

struct BaseView: View {
    
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    @State var frame = 0;
    @State var slowFrame = 0;
    @State var slowestFrame = 0;
    
    var body: some View
    {
        GeometryReader { geo in
            
            Image("WavesDark\(slowestFrame)").resizable().aspectRatio(contentMode: .fit).colorMultiply(Color.cPaleBlue)
                .frame(width: geo.size.width)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.85)
                .onReceive(timer, perform: { _ in
                    frame += 1
                    if(frame % 2 == 0) {slowFrame += 1}
                    if(frame % 3 == 0) {slowestFrame += 1}
                    
                    if(frame > 37) { frame = 0 }
                    if(slowFrame > 37) {slowFrame = 0}
                    if(slowestFrame > 37) {slowestFrame = 0}
                })

            
            Image("WavesDark\(slowFrame)").resizable().aspectRatio(contentMode: .fit).colorMultiply(Color.cLightBlue)
                .frame(width: geo.size.width)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.9)
            
            Image("WavesDark\(frame)").resizable().aspectRatio(contentMode: .fit).colorMultiply(Color.cDarkBlue)
                .frame(width: geo.size.width)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.95)

            
            /*Image("UICoins").resizable()
                .position(x: geo.size.width - 80, y: geo.size.height * 0.06)
                .frame(width: 60.8, height: 28)*/
        }
    }
}
