//
//  ContentView.swift
//  App
//
//  Created by Neeraj Shetkar on 07/12/23.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    struct ElementTip: Tip {
        let info: ElementInfo
        var title: Text {
            Text("What is \(info.name) ?")
        }
        var message: Text? {
            Text("You can get to know new elements everytime you open an app")
        }
        var image: Image? {
            Image(systemName: "atom")
        }
    }
    
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
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
