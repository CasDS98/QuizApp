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
                Button(action: { Task{ await game.onAnswerBefore()}}) {
                    Text("Before").font(.system(size: 24)).foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                    .controlSize(.large)}.buttonStyle(.bordered)
            }
           
            if(!game.isPlaying){
                Button(action: {Task { await game.reset()}}) {
                    Text("Try again").font(.system(size: 24)).foregroundColor(.white)
                        .frame(maxWidth: .infinity).buttonStyle(.bordered)
                    .controlSize(.large)}.buttonStyle(.bordered)
            }
         
            if(game.isPlaying)
            {
                Button(action: { Task{ await game.onAnswerAfter()}}) {
                    Text("After").font(.system(size: 24)).foregroundColor(.white)
                        .frame(maxWidth: .infinity).buttonStyle(.bordered)
                    .controlSize(.large)}.buttonStyle(.bordered)
            }
            
        }.frame(height: 50).background(Color(red: 255.0/255.0, green: 166.0/255.0, blue: 158.0/255.0))
            
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView().environmentObject(QuizGameViewModel())
    }
}
