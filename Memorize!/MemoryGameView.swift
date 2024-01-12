//
//  ContentView.swift
//  Memorize Assignment
//
//  Created by Andrea Russo on 11/10/23.
//

import SwiftUI

struct MemoryGameView: View{
    // Observable ViewModel for memory game logic and state management
    @ObservedObject var viewModel: memoryGameVM
    
    // creates main view body
    var body: some View{
        VStack{
//            Title
            Score
            ScrollView{
                    cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("New Game"){
                viewModel.startNewGame()
            }
            .foregroundColor(Color(rgbaColor: viewModel.chosenTheme.color))
        }
        .padding()
        .navigationTitle("\(viewModel.chosenTheme.name)!")
        .toolbar {
            newGameButton
        }
    }
    
    var newGameButton: some View {
        Button {
            viewModel.startNewGame()
        } label: {
            Text("New Game")
        }
    }
    // grid view of cards
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:70), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in 
                CardView(card: card).aspectRatio(2/3, contentMode: .fit).padding(4).onTapGesture {
                viewModel.choose(card)
                    }
                }
            }
        .foregroundColor(Color(rgbaColor: viewModel.chosenTheme.color))
        }

    // view for each individual card
    struct CardView: View {
        var card: MemoryGameModel<String>.Card
        
        var body: some View {
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content).font(.largeTitle)
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                    
                }
            }
        }
    }
    
//    var Title: some View {
//        Text(viewModel.currentTheme.name)
//            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//            .foregroundColor(viewModel.currentTheme.color)
//    }
    var Score: some View {
        Text("Score \(viewModel.currentScore)")
            .font(.headline)
//            .foregroundColor(viewModel.currentTheme.color)
    }
}

