//
//  ContentView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 08/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var indexY = 0
    @State var offsetY : CGFloat = 0
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    @ObservedObject var timerManager = TimerManager()
    
    @ObservedObject var fishInBowl = Fish()
    
    @ObservedObject var reef = Reef()
    
    
    var body: some View {
        ZStack
        {
            Color.cBlue.ignoresSafeArea()

            GeometryReader { geo in
                
                /*NavBarView(index: self.$indexX, offset: self.$offsetX)
                    .position(x: geo.size.width / 2, y: geo.size.height / 8)*/
                
                VStack(spacing: 0) {
                    
                    BaseView()
                        .frame(width: geo.frame(in : .global).width, height: geo.frame(in : .global).height)
                    ReefView(reef: reef)
                        .frame(width: geo.frame(in : .global).width, height: geo.frame(in : .global).height)
                }
                .offset(y: offsetY)
                .highPriorityGesture(DragGesture()
                
                .onEnded({ (value) in
                    
                    if value.translation.height > 20 {
                        self.changeViewY(up: false)
                    }
                    if -value.translation.height > 20 {
                        self.changeViewY(up: true)
                    }
                }))
                
                HStack(spacing: 0) {
                    if indexY == 0 {
                        HomeView(timerManager: timerManager, fishInBowl: fishInBowl,
                                 reef: reef)
                            .frame(width: geo.frame(in : .global).width, height: geo.frame(in : .global).height)
                    }
                }
            }
        }.animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
    
    func changeViewY(up : Bool) {

        if up {
            if self.indexY == 0 {
                self.indexY = 1
            }
        } else {
            if self.indexY == 1 {
                self.indexY = 0
            }
        }
        
        if indexY == 0 {
            self.offsetY = 0;
        }
        else {
            self.offsetY = -self.height
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("Moving to the background!")
                }
        }
    }
}

struct LargeButton: View {
    
    let label: String
    let buttonColor: Color
    let shadowColor: Color
    
    var body: some View {
        Text(label)
            .font(.custom("Roboto-Light", size: 26))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 32)
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(color: shadowColor, radius: 0, x: 0, y: 5)
    }
}

struct MediumButton: View {
    
    let label: String
    let buttonColor: Color
    let shadowColor: Color
    
    var body: some View {
        Text(label)
            .font(.custom("Roboto-Light", size: 18))
            .foregroundColor(.white)
            .padding(.vertical, 3)
            .padding(.horizontal, 18)
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(color: shadowColor, radius: 0, x: 0, y: 3)
    }
}

struct SmallButton: View {
    
    let label: String
    
    var body: some View {
        Text(label)
            .font(.custom("Roboto-Light", size: 18))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 18)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
    
    }
}

struct IconButton: View {
    
    let label: String
    let buttonColor: Color
    let icon: String
    
    var body: some View {
        HStack {
            
            Image(systemName: icon)
                .foregroundColor( Color.white)
            Text(label)
                .font(.custom("Roboto-Light", size: 16))
                .foregroundColor(.white)

        }
        .padding(.vertical, 4)
        .padding(.horizontal, 10)
        .background(Color.white.opacity(0.2))
        .cornerRadius(100)
    }
}

struct HorizontalButton: View {

    let length: CGFloat;
    
    var body: some View {
        HStack {

        }
        .padding(.vertical, 4)
        .padding(.horizontal, length)
        .background(Color.white.opacity(0.2))
        .cornerRadius(100)
    }
}

extension Color {
    static let cBlue = Color(red: 0.541, green: 0.769, blue: 0.816)
    
    static let cDarkBlue = Color(red: 0.157, green: 0.322, blue: 0.478)
    
    static let cLightBlue = Color(red: 0.655, green: 0.773, blue: 0.922)
    
    static let cPaleBlue = Color(red: 0.827, green: 0.878, blue: 0.918)
    
    static let cSand = Color(red: 0.984, green: 0.933, blue: 0.675)
    
    static let cDarkSand = Color(red: 0.957, green: 0.82, blue: 0.376)
    
    static let cRed = Color(red: 1.0, green: 0.41, blue: 0.38)
    
    static let cDarkRed = Color(red: 0.54, green: 0.0, blue: 0.0)
    
    static let cOffWhite = Color(red: 0.95, green: 0.95, blue: 0.95)
    
    static let cDarkGrey = Color(red: 0.40, green: 0.40, blue: 0.40)
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
