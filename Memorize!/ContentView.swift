//
//  ContentView.swift
//  Memorize Assignment
//
//  Created by Andrea Russo on 11/10/23.
//

import SwiftUI
#Preview {
    ContentView()
}
// making a change
struct ContentView: View{
    // creates content view that is the structure for the app seen by the user
    @State var currentEmojiSet: [String] = flags
    // creates variable that toggles between emoji types
    var body: some View{
        // creates body withing content view
        VStack{
            title
            ScrollView{
                    cards
            }
            gameModeToggle
            }
        // stacks the app vertically
        }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:50))]) {
            ForEach(currentEmojiSet.indices, id: \.self){index in CardView(content: currentEmojiSet[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    var gameModeToggle: some View{
        HStack{
            Spacer()
            flagButton
            Spacer()
            animalButton
            Spacer()
            foodButton
            Spacer()
            }
        // stacks the buttons horizontally
        .imageScale(.large)
        .font(.system(size : 30))
    }
    func gameModeToggle(dictionaryLabel: String, icon: String, label: String) -> some View {
        Button(action: {currentEmojiSet = randomize(array : emojiDictionary[dictionaryLabel]!)}, label: {
            VStack{
                Image(systemName: icon)
                Text(label)
                .font(.system(size : 16))}
        })
    }
    var flagButton: some View{
        gameModeToggle(dictionaryLabel: "flags", icon: "flag.circle", label: "Flags")
    }
    var animalButton: some View{
        gameModeToggle(dictionaryLabel: "animals", icon: "pawprint.circle", label: "Animals")
    }
    var foodButton: some View{
        gameModeToggle(dictionaryLabel: "foods", icon: "fork.knife.circle", label: "Foods")
    }

}
var title: some View{
    Text("Memorize!").font(.title).bold()
}
let flagEmojis: [String] = ["🇺🇸","🇩🇿","🇩🇰","🇩🇪","🇷🇴","🇮🇹","🇮🇱","🇯🇲","🇮🇩","🇳🇬","🇲🇽","🇯🇵","🇮🇳","🇰🇷","🇬🇭","🇭🇷", "🇨🇺", "🇨🇦"]
let animalEmojis: [String] = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁","🐮","🐷","🐸","🐵", "🐥", "🐙"]
let foodEmojis: [String] =  ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥", "🥑", "🥕"]
// creates arrays for different emoji types
func double(array : [String]) -> [String] {
    let doubledArray = array + array
    return doubledArray
}
func randomize(array : [String]) -> [String] {
    var array = array
    array.shuffle()
    return array
}
let flags = double(array: flagEmojis)
let animals = double(array: animalEmojis)
let foods = double(array: foodEmojis)

var emojiDictionary: [String: [String]] = [
    "flags" : flags,
    "animals" : animals,
    "foods" : foods,
]
// created dictionary combining emoji arrays
struct CardView: View{
    let content: String
    @State var isFaceUp = false
    
    var body: some View{
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12.0)
                Group{
                    base.foregroundColor(Color(red: 219.0, green: 237, blue: 255))
                    base.strokeBorder(Color.black, lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.foregroundColor(.red).opacity(isFaceUp ? 0 : 1)
            }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
