//
//  iTunesApp.swift
//  iTunes
//
//  Created by Zane Kleinberg on 8/22/21.
//

import SwiftUI

@main
struct iTunesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().edgesIgnoringSafeArea(.top).frame(minWidth: 1400, maxWidth: .infinity, minHeight: 120, maxHeight: .infinity)
        }.windowStyle(HiddenTitleBarWindowStyle())
    }
}
