//
//  GameView.swift
//  QuizApp
//
//  Created by Cas De Smet on 29/12/2022.
//

import SwiftUI  

struct GameView: View {
    @EnvironmentObject private var game: QuizGameViewModel
    @State private var isLoading = false

    
    var body: some View {
        VStack {
            if(isLoading)
            {
                ProgressView().controlSize(.large)
                    .frame(maxWidth: .infinity)
            }
            else
            {
            QueryOptionView(queryOption: game.queryOptionA).environmentObject(game)
            AnswerView()
            QueryOptionView(queryOption: game.queryOptionB).environmentObject(game)
            ScoreView().environmentObject(game)
            }
        }.background(Color(red: 255.0/255.0, green: 128.0/255.0, blue: 128.0/255.0)).onAppear(){
            self.isLoading = true
            DispatchQueue.main.async {
                game.reset()
                self.isLoading = false
            }
               
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(QuizGameViewModel())
    }
}


