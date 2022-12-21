//
//  ContentView.swift
//  Metaball
//
//  Created by Dominik Kowalewski on 27/10/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
