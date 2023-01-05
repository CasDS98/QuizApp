//
//  ScoreView.swift
//  QuizApp
//
//  Created by user230710 on 1/6/23.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject private var game: QuizGameViewModel
    var body: some View {
        HStack{
            Text("Score: " + String(game.score)).frame(maxWidth: .infinity, maxHeight: 50)
            Text("Highscore: " + String(game.highScore)).frame(maxWidth: .infinity, maxHeight: 50)
        }.background(Color(red: 255.0/255.0, green: 166.0/255.0, blue: 158.0/255.0))
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView().environmentObject(QuizGameViewModel())
    }
}
