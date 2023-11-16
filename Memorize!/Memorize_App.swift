//
//  Memorize_App.swift
//  Memorize!
//
//  Created by Andrea Russo on 11/11/23.
//

import SwiftUI

@main
struct Memorize_App: App {
    @StateObject var game = memoryGameVM(theme: .flag)
    
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: game)
        }
    }
}
