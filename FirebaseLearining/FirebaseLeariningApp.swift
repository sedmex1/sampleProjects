//
//  FirebaseLeariningApp.swift
//  FirebaseLearining
//
//  Created by Dominik Kowalewski on 09/11/2022.
//

import SwiftUI
import Firebase

@main
struct FirebaseLeariningApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
