//
//  QueryOptionView.swift
//  QuizApp
//
//  Created by Cas De Smet on 29/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct QueryOptionView: View {
    let queryOption : QueryOption
    
    init(queryOption: QueryOption) {
        self.queryOption = queryOption
    }
    
    var body: some View {
        VStack{
            
            StrokeText(text: queryOption.title, width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 24, weight: .bold))
                       .frame(maxHeight: .infinity)
            
            StrokeText(text: queryOption.description, width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 12))
                       .frame(height: 90, alignment: .top)
                       .padding([.all], 20)
            
            if(queryOption.isYearVisible){StrokeText(text: String(queryOption.year), width: 1, color: .black)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                .frame(maxHeight: .infinity)}
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background( WebImage(url: URL(string: queryOption.imageUrl))
            .resizable())
            .aspectRatio(contentMode: .fit)
    }
}

struct QueryOptionView_Previews: PreviewProvider {
    static var previews: some View {
        QueryOptionView(queryOption : QueryOption(title: "title", description: "description", year: 2000))
    }
}

