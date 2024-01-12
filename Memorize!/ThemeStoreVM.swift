//
//  ThemeStoreVM.swift
//  Memorize!
//
//  Created by Andrea Russo on 1/11/24.
//

import SwiftUI

class ThemeStoreVM: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
    didSet {
        storeInUserDefaults()
    }
}
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            print("uh-oh")
            insertTheme(named: "Flag", emojis: "🇺🇸🇩🇿🇩🇰🇩🇪🇷🇴🇮🇹🇮🇱🇯🇲🇮🇩🇳🇬🇲🇽🇯🇵🇮🇳🇰🇷🇭🇷🇨🇺🇨🇦", numberOfPairs: 18, color: Color(rgbaColor: RGBAColor(117,58,51,1)))
            insertTheme(named: "Animal", emojis: "🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐵🐥🐙", numberOfPairs: 18, color: Color(rgbaColor: RGBAColor(16,46,165,1)))
            insertTheme(named: "Foods", emojis: "🍏🍎🍐🍊🍋🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥑🥕", numberOfPairs: 18, color: Color(rgbaColor: RGBAColor(129,65,205,1)))
            insertTheme(named: "Red", emojis: "🉐㊙️㊗️🈴🈵🈹🈹🈲🅰️🅱️🆎🆑🅾️🆘❌🛑📛💯", numberOfPairs: 18, color: Color(rgbaColor: RGBAColor(255,0,0,1)))
            insertTheme(named: "Orange", emojis: "🉑☢️☣️📴📳🈶🈚️🈸🈺🈷️✴️🆚", numberOfPairs: 12, color: Color(rgbaColor: RGBAColor(255,165,0,1)))
            insertTheme(named: "Purple", emojis: "💟☮️✝️☪️🕉️☸️🪯✡️🔯🕎☯️☦️🛐⛎♈️♉️♊️♋️", numberOfPairs: 18, color: Color(rgbaColor: RGBAColor(128,0,128,1)))
            insertTheme(named: "Weather", emojis: "☀️🌪☁️☔️❄️", numberOfPairs: 4, color: Color(rgbaColor: RGBAColor(37, 75, 240, 1)))
        }
    }
    
    // MARK: - Intent(s)
    
    private var userDefaultsKey: String { "ThemeStore" + name }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodeThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodeThemes
        }
    }
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    func insertTheme(named name: String, emojis: String? = nil, numberOfPairs: Int = 2, color: Color, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id  ?? 0) + 1
        let theme = Theme(name: name, emojis: emojis ?? "", numberOfPairs: numberOfPairs, color: RGBAColor(color: color), id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
    
    func removeTheme(at index: Int) {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
    }
}

// structure to hold theme properties
struct Theme: Codable, Identifiable, Hashable {
    var name: String
    var emojis: String
    var removedEmojis: String
    var numberOfPairs: Int
    var color: RGBAColor
    let id: Int
    
    fileprivate init(name: String, emojis: String, numberOfPairs: Int, color: RGBAColor, id: Int) {
        self.name = name
        self.emojis = emojis
        self.removedEmojis = ""
        self.numberOfPairs = max(2, min(numberOfPairs, emojis.count))
        self.color = color
        self.id = id
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

//#Preview {
//    ThemeStoreVM()
//}
