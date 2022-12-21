//
//  Intro.swift
//  IntroAnimation
//
//  Created by Dominik Kowalewski on 07/11/2022.
//

import SwiftUI

//MARK: Intro Model And Sample Intro's

struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var imageName: String
    var title: String
}

var intros: [Intro] = [
    .init(imageName: "Image1", title: "Relax"),
    .init(imageName: "Image5", title: "Care"),
    .init(imageName: "Image3", title: "Mood Dairy"),
]

var dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
