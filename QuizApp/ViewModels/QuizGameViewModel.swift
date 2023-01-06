//
//  QuizGameViewModel.swift
//  QuizApp
//
//  Created by user230710 on 12/30/22.
//

import Foundation

class QuizGameViewModel: ObservableObject{
    @Published private var model: QuizGame
    
    init() {
        model = QuizGame()
    }
    
    var queryOptionA: QueryOption
    {
        model.queryOptionA
    }
    
    var queryOptionB: QueryOption
    {
        model.queryOptionB
    }
    
    var score: Int
    {
        model.score
    }
    
    var highScore: Int
    {
        model.highScore
    }
    
    var isPlaying: Bool
    {
        model.isPlaying
    }
    
    func onAnswerAfter()
    {
        model.registerAnswer(answer: .after)
    }
    
    func onAnswerBefore()
    {
        model.registerAnswer(answer: .before)
    }
    
    func reset()
    {
        model.reset()
    }
}


