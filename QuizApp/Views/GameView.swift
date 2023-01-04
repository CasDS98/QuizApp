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
            QueryOptionView(queryOption: game.queryOptionA).environmentObject(game).background(Color(red: 147.0/255.0, green: 225.0/255.0, blue: 216.0/255.0))
            AnswerView()
            QueryOptionView(queryOption: game.queryOptionB).environmentObject(game).background(Color(red: 221.0/255.0, green: 225.0/255.0, blue: 247.0/255.0))
            Text("score: " + String(game.score)).frame(maxWidth: .infinity, maxHeight: 50).background(Color(red: 255.0/255.0, green: 166.0/255.0, blue: 158.0/255.0))
            }
            }.background(Color(red: 255.0/255.0, green: 166.0/255.0, blue: 158.0/255.0)).onAppear(){
                isLoading = true
                Task{ await game.reset()
                    isLoading = false
                }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(QuizGameViewModel())
    }
}
