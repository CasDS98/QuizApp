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
            
            StrokeText(text: queryOption.title, width: 2, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 28, weight: .bold))
                       .frame(maxHeight: .infinity)
            
            StrokeText(text: queryOption.description, width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 18))
                       .frame(height: 90, alignment: .top)
                       .padding([.all], 20)
            
            if(queryOption.isYearVisible){StrokeText(text: String(queryOption.year), width: 2, color: .black)
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                .frame(maxHeight: .infinity)}
                
            if(queryOption.isUpper){StrokeText(text: "Happened", width: 2, color: .black)
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                .frame(maxHeight: .infinity)}
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.zero).background( WebImage(url: URL(string: queryOption.imageUrl)).placeholder {
            Rectangle().foregroundColor(Color(red: 255.0/255.0, green: 191.0/255.0, blue: 191.0/255.0))
            }.resizable().cornerRadius(20))
           
    }
}

struct QueryOptionView_Previews: PreviewProvider {
    static var previews: some View {
        QueryOptionView(queryOption : QueryOption(title: "title", description: "description", year: 2000))
    }
}

