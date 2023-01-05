//
//  StartScreenView.swift
//  QuizApp
//
//  Created by user230710 on 1/4/23.
//

import SwiftUI

struct StartScreenView: View {
    @EnvironmentObject private var game: QuizGameViewModel
    
    var body: some View {
        VStack{
            NavigationView {
                NavigationLink(destination: GameView().environmentObject(game)) {
                    Text("Start Game")
                    
                }
            }
            Text("Highscore: " + String(game.highScore))
      }
    }
}

struct StartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreenView().environmentObject(QuizGameViewModel())
    }
}
