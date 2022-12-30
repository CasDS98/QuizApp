//
//  GameView.swift
//  QuizApp
//
//  Created by Cas De Smet on 29/12/2022.
//

import SwiftUI  

struct GameView: View {
    @EnvironmentObject private var game: QuizGameViewModel
    
    var body: some View {
        VStack {
            QueryOptionView(queryOption: game.queryOptionA).environmentObject(game)
            AnswerView()
            QueryOptionView(queryOption: game.queryOptionB).environmentObject(game)
            Text("score: " + String(game.score))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(QuizGameViewModel())
    }
}
