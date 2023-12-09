//  DetailsView.swift
//  App
//
//  Created by Neeraj Shetkar on 08/12/23.
//

import SwiftUI

struct iPhoneDetails: View {
    @Environment(\.colorScheme) var colorScheme
    let info: ElementInfo
    
    var body: some View {
        VStack {
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
    }
}

#Preview {
    iPhoneDetails(info: mockData)
}

