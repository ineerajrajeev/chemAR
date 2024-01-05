//
//  TitleBlockDetailsPage.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 06/01/24.
//

import SwiftUI

struct TitleBlockDetailsPage: View {
    
    @Environment(\.colorScheme) var colorScheme
    var info: ElementInfo
    
    var body: some View {
        ZStack {
            HStack {
                VStack (spacing: 16) {
                    Text(info.symbol)
                        .font(.system(size: 35))
                        .padding(35)
                        .background {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(Color(uiColor: .secondarySystemBackground))
                                .shadow(radius: 5)
                        }
                    HStack {
                        Text("\(info.name)")
                            .fontWeight(.bold)
                            .font(.title)
                    }
                    HStack {
                        NavigationLink(
                            destination: ARViewContainer(info: info),
                            label: {
                                Label("AR View", systemImage: "rotate.3d.fill")
                                    .frame(width: 120, height: 35)
                                    .background(colorScheme == .dark ? Color.white : Color.black)
                                    .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                    .cornerRadius(10)
                            }
                        )
                    }
                    HStack {
                        Text("Atomic number: ")
                            .fontWeight(.bold)
                            .font(.title2)
                        Text("\(info.number)")
                            .fontWeight(.thin)
                            .font(.title2)
                        Spacer()
                        
                    }
                    HStack {
                        Text("Shells: ")
                            .fontWeight(.bold)
                            .font(.title2)
                        Text("\(info.shells.count)")
                            .fontWeight(.thin)
                            .font(.title2)
                        Spacer()
                    }
                }
            }
            .padding(25)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
            )
            .cornerRadius(10)
        }
    }
}

#Preview {
    TitleBlockDetailsPage(info: mockData)
}
