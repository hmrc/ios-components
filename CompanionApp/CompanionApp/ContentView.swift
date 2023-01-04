//
//  ContentView.swift
//  CompanionApp
//
//  Created by Chris J W Walker on 04/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .organisms
    
    enum Tab {
        case organisms
        case molecules
        case atoms
        case colours
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OrganismsView()
                .tabItem {
                    Label("Organisms", image: "organism")
                }
                .tag(Tab.organisms)
            
            MoleculesView()
                .tabItem {
                    Label("Molecules", image: "molecule")
                }
                .tag(Tab.molecules)
            
            AtomsView()
                .tabItem {
                    Label("Atoms", image: "atom")
                }
                .tag(Tab.atoms)
            
            ColoursView()
                .tabItem {
                    Label("Colours", image: "colours")
                }
                .tag(Tab.colours)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
