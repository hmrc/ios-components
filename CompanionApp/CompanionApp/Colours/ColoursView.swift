//
//  ColoursView.swift
//  CompanionApp
//
//  Created by Chris J W Walker on 04/01/2023.
//

import SwiftUI

struct ColoursView: View {
    private var colours: [Color] = [
        Color.black,
        Color.white
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(colours, id: \.self) { colour in
                    ColourRow(color: colour)
                }
            }
            .navigationTitle("Colours")
        }
    }
}

struct ColoursView_Previews: PreviewProvider {
    static var previews: some View {
        ColoursView()
    }
}
