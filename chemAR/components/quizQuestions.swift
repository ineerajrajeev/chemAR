//
//  quizQuestions.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct quizQuestions: View {
    
    let info = getRandomElement(from: elements) ?? mockData
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    quizQuestions()
}
