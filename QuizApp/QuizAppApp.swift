//
//  QuizAppApp.swift
//  QuizApp
//
//  Created by Cas De Smet on 30/10/2022.
//
//test commit

import SwiftUI

@main
struct QuizAppApp: App {
    
    @StateObject private var game = QuizGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            GameView().environmentObject(game)
        }
    }
}
