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
    
    var properties: [(String, String, String, Color)] = []
    
    var block: Blocks = .all
        
    init() {
        self.properties = [
            ("Period", "\(info.period)", "mappin.and.ellipse.circle.fill", Color.red),
            ("Block", "\(info.block)", "tablecells.badge.ellipsis", Color.green),
            ("Atomic Number", "\(info.number)", "number.circle", Color.orange),
            ("Atomic Weight", "\(info.atomicWeight)", "scalemass", Color.pink),
            ("Electron Affinity", "\((info.electron_affinity != nil) ? String(format: "%.1f",info.electron_affinity!) : "Not available")", "atom", Color.indigo),
            ("Category", "\(info.category)", "tray.full.fill", Color.purple),
        ]
        if info.block == "s" {
            self.block = .s
        } else if info.block == "p" {
            self.block = .p
        } else if info.block == "d" {
            self.block = .d
        } else if info.block == "f" {
            self.block = .f
        }
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Spacer()
                            VStack {
                                Text(info.symbol)
                                    .font(.system(size: 80))
                                    .frame(width: 140, height: 80)
                                    .padding(44)
                                    .background {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .foregroundColor(Color(uiColor: .secondarySystemBackground))
                                    }
                                Text(info.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Atom(info: info)
                                    .font(.title2)
                                    .padding(35)
                                    .frame(width: 350, height: 350)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width * 0.5)
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
                                )
                            NavigationLink(
                                destination: Details(info: info),
                                label: {
                                    Label("More Info", systemImage: "info.circle")
                                        .frame(width: 150, height: 50)
                                        .background(colorScheme == .dark ? Color.white : Color.black)
                                        .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                                        .clipShape(Capsule())
                                }
                            )
                        }
                        .padding()
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 16) {
                            ForEach(properties, id: \.0) { property in
                                if property.0 == "Block" {
                                    
                                    NavigationLink(
                                        destination: BlockView(selectedBlock: block),
                                        label: {
                                            PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                        }
                                    )
                                } else {
                                    PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: geometry.size.width * 0.5)
                }
            }
        }
    }
}

struct PropertyCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
                    .textCase(.uppercase)
            }
            .padding(.vertical, 8)
            Spacer()
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(color.opacity(0.1))
        )
    }
}


#Preview {
    iPadHome()
}
