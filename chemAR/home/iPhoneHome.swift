//
//  iPhoneHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct iPhoneHome: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let info = getRandomElement(from: elements)!
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(info.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(
                        destination: Details(info: info),
                        label: {
                            Label("Info", systemImage: "info.circle")
                                .frame(width: 125, height: 50)
                                .background(colorScheme == .dark ? Color.white : Color.black)
                                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                .clipShape(Capsule())
                        }
                    )
                }
                VStack {
                    Atom(info: info)
                        .font(.title2)
                        .padding(35)
                        .frame(width: 350, height: 350)
                        .multilineTextAlignment(.leading)
                    ScrollView {
                        VStack {
                            Text("\(info.description)")
                            Text("Electronic Configuration")
                                .fontWeight(.bold)
                            Text(info.electron_configuration_semantic)
                            itemDetails(param1: "Atomic Weight", val1: String(format: "%.3f", info.atomicWeight),
                                        param2: "Density", val2: info.density != nil ? String(format: "%.3f", info.density!) : "Not Available")
                            itemDetails(param1: "Period", val1: "\(info.period)",
                                        param2: "Block", val2: "\(info.block)")
                        }
                            .frame(height: 300)
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    iPhoneHome()
}
