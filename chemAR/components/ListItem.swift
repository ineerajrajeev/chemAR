//
//  Details.swift
//  App
//
//  Created by Neeraj Shetkar on 07/12/23.
//

import SwiftUI

struct ListItem: View {
    @Environment(\.colorScheme) var colorScheme
    var info: ElementInfo

    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .frame(width: 60, height: 60)
                    Text("\(info.symbol)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.black)
                }
                .padding(8)
                .shadow(radius: 2)
                VStack {
                    HStack {
                        Text("\(info.number)")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(info.name)")
                            .fontWeight(.bold)
                        Spacer()
                        Text("Atomic Weight: ")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        Text(String(format: "%.1f",info.atomicWeight))
                            .fontWeight(.thin)
                            .font(.subheadline)
                    }
                    Spacer()
                    HStack {
                        Text("Category: ")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        Text("\(info.category.capitalized(with: .autoupdatingCurrent))")
                            .fontWeight(.thin)
                            .font(.subheadline)
                        Spacer()
                        Text("State: ")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        Text("\(info.phase.capitalized(with: .autoupdatingCurrent))")
                            .fontWeight(.thin)
                            .font(.subheadline)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ListItem(info: mockData)
}
