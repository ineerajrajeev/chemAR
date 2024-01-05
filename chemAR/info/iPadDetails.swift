//
//  DetailsView.swift
//  App
//
//  Created by Neeraj Shetkar on 08/12/23.
//

import SwiftUI

struct iPadDetails: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isTitleBarHidden = false
    
    let info: ElementInfo

    @State var temperature_in_c: Bool = true
    
    init(info: ElementInfo) {
        
        self.info = info
    }
        
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            VStack {
                                Spacer()
                                Atom(info: info)
                                    .font(.title2)
                                    .padding(35)
                                    .frame(width: 350, height: 300)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if !isTitleBarHidden {
                                    TitleBlockDetailsPage(info: info)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                        .frame(width: 325, height: 350)
                                }
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.98)
                    .padding()
                    .gesture(
                        swipeGesture()
                    )
                    VStack {
                        VStack(alignment: .trailing) {
                            Text("\(info.description)")
                                .font(.title2)
                                .padding(35)
                                .frame(width: .infinity, height: geometry.size.height * 0.45)
                                .multilineTextAlignment(.leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.blue.opacity(0.2))
                                        .shadow(radius: 25)
                                )
                        }
                        .padding()
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 16) {
                                ForEach(properties, id: \.0) { property in
                                    PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(width: geometry.size.width * 0.5)
                }
            }
        }
    }
    
    func swipeGesture() -> some Gesture {
        return DragGesture()
            .onChanged { gesture in
                if gesture.translation.height > 0 {
                    withAnimation {
                        self.isTitleBarHidden = true
                    }
                } else {
                    withAnimation {
                        self.isTitleBarHidden = false
                    }
                }
            }
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
                let temp_in_c = (Float(value)! - 32.0) * (5/9)
                return "\(String(format: "%.1f",temp_in_c)) °C"
            }
        }
    }
}

#Preview {
    iPadDetails(info: mockData)
}
