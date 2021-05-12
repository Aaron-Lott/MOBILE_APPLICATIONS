//
//  ModalView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 11/05/2021.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ModalView<Content: View> : View {
    @GestureState private var dragState = DragState.inactive
    @Binding var isShown:Bool
    var color:Color = Color.cOffWhite
    
    @ObservedObject var timerManager = TimerManager()
    @ObservedObject var fishInBowl = Fish()
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold = modalHeight * (2/3)
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold{
            isShown = false
        }
    }
    
    var modalHeight:CGFloat = 400
    
    
    var content: () -> Content
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
        }
        .onEnded(onDragEnded)
        return Group {
            ZStack {
                //Background
                Spacer()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .background(isShown ? Color.black.opacity( 0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
        .gesture(
                        TapGesture()
                            .onEnded { _ in
                                UIApplication.shared.endEditing()
                                self.isShown = false
                        }
                )
                
                //Foreground
                VStack{
                    Spacer()
                    ZStack{
                        
                        color.opacity(1.0)
                            .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                            .shadow(radius: 5)
                        self.content()
                            .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                            .clipped()
                        
                        VStack (spacing: 22.9){
                            
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10, corners: [.topLeft, .topRight])
                                    .frame(width: UIScreen.main.bounds.size.width, height: 40)
                                    .foregroundColor(Color.cBlue)
                                
                                Button(action: {
                                    isShown = false;
                                }) {
                                    HorizontalButton(length: 40)
                                }
                            }
                                                     
                        ShopView(timerManager: timerManager, fishInBowl: fishInBowl)
                            
                            HStack (spacing: 40){
                                
                                ZStack {
                                    
                                    //5.925 SCALE FACTOR
                                    
                                    Image("FishBowl")
                                        .resizable()
                                        .frame(width: 101, height: 105).colorMultiply(Color.cSand)
                                    
                                    Image("WaterFill5")
                                        .resizable()
                                        .frame(width: 81, height: 84)
                                    
                                    Image("\(fishInBowl.fishType)")
                                        .resizable()
                                        .frame(width: 34, height: 34)
                                        .offset(x: 0, y: 5)
                                }
                                
                                Label("\(fishInBowl.minutesTillRelease)", systemImage: "timer").foregroundColor(Color.cDarkGrey)
                                
                                Button(action: {
                                    isShown = false;
                                    timerManager.start()
                                }) {
                                    MediumButton(label: "Grow", buttonColor: Color.cLightBlue, shadowColor: Color.cDarkBlue)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.size.width, height: modalHeight / 3)
                            .background(Color.white)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                            .shadow(radius: 5)
                        }
                    }
                    .offset(y: isShown ? ((self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : 0) : modalHeight)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(drag)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}



func fraction_progress(lowerLimit: Double = 0, upperLimit:Double, current:Double, inverted:Bool = false) -> Double{
    var val:Double = 0
    if current >= upperLimit {
        val = 1
    } else if current <= lowerLimit {
        val = 0
    } else {
        val = (current - lowerLimit)/(upperLimit - lowerLimit)
    }
    
    if inverted {
        return (1 - val)
        
    } else {
        return val
    }
    
}
