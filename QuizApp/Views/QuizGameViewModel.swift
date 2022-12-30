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
        model.querOptionA
    }
    
    var queryOptionB: QueryOption
    {
        model.querOptionB
    }
}
