//
//  DetailsView.swift
//  App
//
//  Created by Neeraj Shetkar on 08/12/23.
//

import SwiftUI

struct iPadDetails: View {
    @Environment(\.colorScheme) var colorScheme
    let info: ElementInfo

    @State var temperature_in_c: Bool = true
    
    init(info: ElementInfo) {
        
        self.info = info
    }
        
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Atom(info: info)
                }
                Spacer()
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
                    ScrollView {
                        VStack(alignment: .trailing) {
                            Text("\(info.description)")
                                .font(.title2)
                                .padding(35)
                                .frame(width: 580)
                                .multilineTextAlignment(.leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.blue.opacity(0.2))
                                        .shadow(radius: 25)
                                )

                        }
                        .padding()
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 16) {
                            ForEach(properties, id: \.0) { property in
                                if property.0 == "Period" {
                                    NavigationLink(
                                        destination: BlockView(selectedPeriod: Int(property.1)!),
                                        label: {
                                            PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                        }
                                    )
                                } else if property.0 == "Melting Point" || property.0 == "Boiling Point" {
                                    Button(action: {
                                        temperature_in_c.toggle()
                                    }, label: {
                                        PropertyCard(title: property.0, value: temp(property.1), icon: property.2, color: property.3)
                                    })
                                } else {
                                    PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                }
                            }
                        }
                    }
                }
                .font(.title2)
            }
        }
        .padding()
    }
    
    private var properties: [(String, String, String, Color)] {
        [
            ("Discovered By", "\(info.discovered_by ?? "Not available")", "person.crop.circle", Color.red),
            ("Appearance", "\(info.appearance)", "eye", Color.red),
            ("Period", "\(info.period)", "mappin.and.ellipse.circle", Color.red),
            ("Block", "\(info.block)", "tablecells.badge.ellipsis", Color.green),
            ("Atomic Number", "\(info.number)", "number.circle", Color.orange),
            ("Atomic Weight", "\(info.atomicWeight) amu", "scalemass", Color.pink),
            ("Density", "\((info.density != nil) ? String(format: "%.1f",info.density!) : "Not available")", "increase.indent", Color.pink),
            ("Electron Affinity", "\((info.electron_affinity != nil) ? String(format: "%.1f",info.electron_affinity!) : "Not available") Kj/mol", "atom", Color.indigo),
            ("Melting Point", "\((info.melting_point != nil) ? String(format: "%.1f",info.melting_point!) : "Not available")", "drop.degreesign.fill", Color.blue),
            ("Boiling Point", "\((info.boiling_point != nil) ? String(format: "%.1f",info.boiling_point!) : "Not available")", "bubbles.and.sparkles", Color.orange),
            ("Category", "\(info.category)", "tray.full", Color.purple),
        ]
    }
    
    private func temp(_ value: String) -> String {
        var temparature = ""
        if value == "Not available" {
            temparature = value
            return temparature
        } else {
            if !temperature_in_c {
                return value + "°F"
            } else {
                var temp_in_c = (Float(value)! - 32.0) * (5/9)
                return "\(String(format: "%.1f",temp_in_c)) °C"
            }
        }
    }
}

#Preview {
    iPadDetails(info: mockData)
}
