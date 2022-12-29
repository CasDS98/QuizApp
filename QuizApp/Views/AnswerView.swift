//
//  AnswerView.swift
//  QuizApp
//
//  Created by user230710 on 12/29/22.
//

import SwiftUI

struct AnswerView: View {
    var body: some View {
        HStack{
            Button {
            } label: {
                Text("Before").foregroundColor(.white)
            }.frame(maxWidth: .infinity).buttonStyle(.bordered)
                .controlSize(.large)
            
            Button {
            } label: {
                Text("After").foregroundColor(.white)
            }.frame(maxWidth: .infinity).buttonStyle(.bordered)
                .controlSize(.large)
        }.background(Color.red).border(.black)
            
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView()
    }
}
