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
        ScrollView {
            VStack(spacing: 20) {
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
                HStack {
                    Atom(info: info)
                }
                .frame(width: 275, height: 275)
                .padding()
                Text(info.description)
                // Electron
                Text("Electronic Configuration")
                    .fontWeight(.bold)
                Text(info.electron_configuration_semantic)
                itemDetails(param1: "Discovered By", val1: info.discovered_by != nil ? info.discovered_by! : "Not Available",
                            param2: "Appearance", val2: info.appearance != "None" ? info.appearance : "Not Available")
                .padding()
                itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                            param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                .padding()
                itemDetails(param1: "Period", val1: "\(info.period)",
                            param2: "Block", val2: "\(info.block)")
                .padding()
                itemDetails(param1: "Melting Point", val1: info.melting_point != nil ? String(format: "%.3f", info.melting_point!) : "Not Available",
                            param2: "Boiling Point", val2: info.boiling_point != nil ? String(format: "%.3f", info.boiling_point!) : "Not Available")
                .padding()
                itemDetails(param1: "Electron affinity", val1: info.electron_affinity != nil ? String(format: "%.3f", info.electron_affinity!) : "Not Available",
                            param2: "Molar heat", val2: info.molar_heat != nil ? String(format: "%.3f", info.molar_heat!) : "Not Available")
                .padding()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    iPhoneDetails(info: mockData)
}

