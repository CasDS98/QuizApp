//
//  AnswerView.swift
//  QuizApp
//
//  Created by user230710 on 12/29/22.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject private var game: QuizGameViewModel
    @State private var isLoading = false
    
    var body: some View {
        HStack{
            if(isLoading)
            {
                ProgressView().controlSize(.large)
                    .frame(maxWidth: .infinity)
            }
            else
            {
                if(game.isPlaying)
                {
                    Button(action: {
                        self.isLoading = true
                       
                        DispatchQueue.main.async {
                            game.onAnswerBefore()
                            self.isLoading = false
                        }
                        
                    }) {
                        Text("Before").font(.system(size: 24)).foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        .controlSize(.large)}.buttonStyle(.bordered)
                }
                
                if(!game.isPlaying){
                    Button(action: {
                        self.isLoading = true
                        DispatchQueue.main.async {
                            game.reset()
                            self.isLoading = false
                        }
                        
                    }) {
                        Text("Try again").font(.system(size: 24)).foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        .controlSize(.large)}.buttonStyle(.bordered)
                }
                 else
                {
                     Text("OR").font(.system(size: 24)).foregroundColor(.white)
                         .frame(maxWidth: .infinity)
                }
                
                if(game.isPlaying)
                {
                    Button(action: {
                        self.isLoading = true
                        DispatchQueue.main.async {
                            game.onAnswerAfter()
                            self.isLoading = false
                        }
                       
                    }) {
                        Text("After").font(.system(size: 24)).foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                        .controlSize(.large)}.buttonStyle(.bordered)
                }
            }
        }.frame(height: 50).padding()
            
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView().environmentObject(QuizGameViewModel())
    }
}
