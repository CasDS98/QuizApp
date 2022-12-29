//
//  GameView.swift
//  QuizApp
//
//  Created by Cas De Smet on 29/12/2022.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack {
            QueryOptionView()
            QueryOptionView()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
