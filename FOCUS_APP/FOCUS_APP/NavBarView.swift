//
//  NavBarView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 19/03/2021.
//


import SwiftUI

struct NavBarView: View
{
    @Binding var index : Int
    @Binding var offset : CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View
    {
        VStack(alignment: .center) {
            
            HStack(spacing: 40){
                Button(action: {
                    
                    self.index = 1
                    self.offset = 0
                }) {
                    
                    VStack(spacing: 10){

                        Image(systemName: "tray.fill")
                            .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.5))
                        Capsule()
                            .fill(self.index == 1 ? Color.white : Color.clear)
                            .frame(width: 80, height: 4)
                    }
                }
                
                Button(action: {
                    
                    self.index = 2
                    self.offset = -self.width
                    
                }) {
                    
                    VStack(spacing: 10){
                        Image(systemName: "house.fill")
                                .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.5))
                        Capsule()
                            .fill(self.index == 2 ? Color.white : Color.clear)
                            .frame(width: 80, height: 4)
                    }
                }
                
                Button(action: {
                    
                    self.index = 3
                    self.offset = -self.width * 2
                    
                }) {
                    
                    VStack(spacing: 10){
                        Image(systemName: "cart.fill")
                                .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.5))
                        Capsule()
                            .fill(self.index == 3 ? Color.white : Color.clear)
                            .frame(width: 80, height: 4)
                    }
                }

            }
        }
    }
}
