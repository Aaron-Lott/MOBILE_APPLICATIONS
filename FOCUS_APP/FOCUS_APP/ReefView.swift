//
//  ReefView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 19/03/2021.
//

import SwiftUI

struct ReefView: View {
    
    @ObservedObject var reef = Reef()
    
    var body: some View
    {
        GeometryReader { geo in
            Image("Background").resizable()
                .frame(width: geo.size.width)
                .clipped()
            
            ForEach(0 ..< reef.releasedFish.count, id: \.self) { fish in
                
                Image("\(reef.releasedFish[fish])")
                    .position(x: CGFloat.random(in: geo.size.width * 0.1...geo.size.width * 0.9), y: CGFloat.random(in: geo.size.height * 0.1 ... geo.size.height * 0.9))
        
            }
        }
    }
}

class Reef: ObservableObject {
    
    @Published var releasedFish : [FishType] = []
    
    func ReleaseFish(type : FishType) {
        self.releasedFish += [type]
    }
}

