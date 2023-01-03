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
    var backgroundImage = Image("testImage")
    
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
                       
            
            StrokeText(text: String(queryOption.year), width: 1, color: .black)
                       .foregroundColor(.white)
                       .font(.system(size: 18, weight: .bold))
                       .frame(maxHeight: .infinity)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background( WebImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Biblioth%C3%A8que_nationale_de_France_-_Bible_de_Vivien_Ms._Latin_1_folio_423r_d%C3%A9tail_Le_comte_Vivien_offre_le_manuscrit_de_la_Bible_faite_%C3%A0_l%27abbaye_de_Saint-Martin_de_Tours_%C3%A0_Charles_le_Chauve.jpg/50px-thumbnail.jpg"))
            .resizable())
            .aspectRatio(contentMode: .fit)
    }
}

struct QueryOptionView_Previews: PreviewProvider {
    static var previews: some View {
        QueryOptionView(queryOption : QueryOption(title: "title", description: "description", year: 2000))
    }
}

