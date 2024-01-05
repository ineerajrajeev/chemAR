//
//  ContentView.swift
//  App
//
//  Created by Neeraj Shetkar on 07/12/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    TabView {
                        VStack {
                            if UIDevice.isiPad {
                                iPadHome()
                            } else {
                                iPhoneHome()
                            }
                        }
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        BlockView()
                        .tabItem {
                            Label("Directory", systemImage: "book.pages")
                        }
                        QuizQuestions()
                        .tabItem {
                            Label("Quiz", systemImage: "doc.questionmark")
                        }
                        PeriodicTable()
                        .tabItem {
                            Label("Periodic Table", systemImage: "doc.questionmark")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
