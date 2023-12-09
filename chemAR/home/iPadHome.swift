//
//  iPadHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct iPadHome: View {
    @Environment(\.colorScheme) var colorScheme
    
    let info = getRandomElement(from: elements)!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text(info.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            NavigationLink(
                                destination: ARViewContainer(info: info),
                                label: {
                                    Label("AR View", systemImage: "rotate.3d.fill")
                                        .frame(width: 150, height: 50)
                                        .background(colorScheme == .dark ? Color.white : Color.black)
                                        .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                        .clipShape(Capsule())
                                }
                            )
                        }
                        Atom(info: info)
                        Text("\(info.description)\n")
                        Text("Electronic Configuration")
                            .fontWeight(.bold)
                        Text(info.electron_configuration_semantic)
                        itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                    param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                        itemDetails(param1: "Period", val1: "\(info.period)",
                                    param2: "Block", val2: "\(info.block)")
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.5, height: .infinity)
                    VStack {
                        Text("Quiz")
                        // Add your quiz content here or modify as needed
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.5) // Right half set to 50% of screen width
                }
            }
        }
    }
}


#Preview {
    iPadHome()
}
