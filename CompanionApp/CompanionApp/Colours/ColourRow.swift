//
//  ColourRow.swift
//  CompanionApp
//
//  Created by Chris J W Walker on 04/01/2023.
//

import SwiftUI

struct ColourRow: View {
    var color: Color
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 50, height: 50)
            
            if let hex = color.toHex() {
                Text("\(color.description) (#\(hex)")
                    .bold()
            }
            
            Spacer()
        }
    }
}

struct ColourRow_Previews: PreviewProvider {
    static var previews: some View {
        ColourRow(color: Color.red)
    }
}
