//
//  StorageView.swift
//  FOCUS_APP
//
//  Created by Aaron Lott on 11/03/2021.
//

import SwiftUI

struct StorageView: View
{
    var body: some View
    {
        GeometryReader { geo in
            ZStack()
            {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(Color.cSand)
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.6)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2.1)
                        .shadow(color: Color.cDarkSand, radius: 0, x: -10, y: 10)
            }
        }
    }
}
