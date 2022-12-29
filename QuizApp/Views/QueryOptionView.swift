//
//  QueryOptionView.swift
//  QuizApp
//
//  Created by Cas De Smet on 29/12/2022.
//

import SwiftUI

struct QueryOptionView: View {
    var body: some View {
        VStack{
            StrokeText(text: "Title", width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 24, weight: .bold))
            StrokeText(text: "description of event", width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 12))
            StrokeText(text: "year", width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 18, weight: .bold))
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background( Image("testImage")
            .resizable())
            .aspectRatio(contentMode: .fit)
    }
}

struct QueryOptionView_Previews: PreviewProvider {
    static var previews: some View {
        QueryOptionView()
    }
}

