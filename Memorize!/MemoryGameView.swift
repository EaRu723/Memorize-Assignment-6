//
//  ContentView.swift
//  Memorize Assignment
//
//  Created by Andrea Russo on 11/10/23.
//

import SwiftUI
#Preview {
    MemoryGameView()
}
struct MemoryGameView: View{
    // Observable ViewModel for memory game logic and state management
    @ObservedObject var viewModel: memoryGameVM
    
    init(viewModel: memoryGameVM){
        self.viewModel = viewModel
    }
    // initialize theme to be flag
   init(theme: memoryGameVM.GameTheme = .flag) {
       self.viewModel = memoryGameVM(theme:theme)
   }
    // creates main view body
    var body: some View{
        VStack{
            Title
            Score
            ScrollView{
                    cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("New Game"){
                startNewGame()
            }
        }
        .padding()
        // stacks the app vertically
    }
    // grid view of cards
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:70), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in 
                CardView(card: card, themeColor: viewModel.currentTheme.color).aspectRatio(2/3, contentMode: .fit).padding(4).onTapGesture {
                viewModel.choose(card)
                    }
                }
            }
        .foregroundColor(viewModel.currentTheme.color)
        }

    // view for each individual card
    struct CardView: View{
        let card: MemoryGameModel<String>.Card
        var themeColor: Color
        
        init(card: MemoryGameModel<String>.Card, themeColor: Color) {
            self.card = card
            self.themeColor = themeColor
        }
        
        // the body of the card view
        var body: some View{
                ZStack {
                    let base = RoundedRectangle(cornerRadius: 13.0)
                    Group{
                        base.foregroundColor(.white)
                        base.strokeBorder(themeColor, lineWidth: 2)
                        Text(card.content)
                            .font(.system(size: 150))
                            .minimumScaleFactor(0.01)
                            .aspectRatio(contentMode: .fit)
                    }
                    .opacity(card.isFaceUp ? 1 : 0)
                    base.fill().opacity(card.isFaceUp ? 0 : 1)
                }
                .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }
    func startNewGame() {
        viewModel.startNewGame()
    }
    var Title: some View {
        Text(viewModel.currentTheme.name)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(viewModel.currentTheme.color)
    }
    var Score: some View {
        Text("Score \(viewModel.currentScore)")
            .font(.headline)
            .foregroundColor(viewModel.currentTheme.color)
    }
}

