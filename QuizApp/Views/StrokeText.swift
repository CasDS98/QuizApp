//
//  StrokeText.swift
//  QuizApp
//
//  Created by user230710 on 12/29/22.
//

import SwiftUI

//code from https://stackoverflow.com/questions/57334125/how-to-make-text-stroke-in-swiftui
struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}


