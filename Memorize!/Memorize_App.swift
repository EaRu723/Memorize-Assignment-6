//
//  Memorize_App.swift
//  Memorize!
//
//  Created by Andrea Russo on 11/11/23.
//

import SwiftUI

@main
struct Memorize_App: App {
    @StateObject var themeStoreVM = ThemeStoreVM(named: "default")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser()
                .environmentObject(themeStoreVM)
        }
    }
}
