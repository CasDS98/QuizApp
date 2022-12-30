//
//  AnswerView.swift
//  QuizApp
//
//  Created by user230710 on 12/29/22.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject private var game: QuizGameViewModel

    
    var body: some View {
        HStack{
            if(game.isPlaying)
            {
                Button(action: {game.onAnswerBefore()}) {
                    Text("Before").foregroundColor(.white)
                        .frame(maxWidth: .infinity).buttonStyle(.bordered)
                    .controlSize(.large)}
            }
           
            if(!game.isPlaying){
                Button(action: {game.reset()}) {
                    Text("Try again").foregroundColor(.white)
                        .frame(maxWidth: .infinity).buttonStyle(.bordered)
                    .controlSize(.large)}
            }
         
            if(game.isPlaying)
            {
                Button(action: {game.onAnswerAfter()}) {
                    Text("After").foregroundColor(.white)
                        .frame(maxWidth: .infinity).buttonStyle(.bordered)
                    .controlSize(.large)}
            }
            
        }.background(Color.red).border(.black)
            
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView().environmentObject(QuizGameViewModel())
    }
}
