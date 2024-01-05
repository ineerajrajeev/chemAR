//
//  iPadHome.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct iPadHome: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isTitleBarHidden = false
    
    @State var info: ElementInfo
    
    var properties: [(String, String, String, Color)] = []
    
    var block: Blocks = .all
        
    init() {
        
        self._info = State(initialValue: getRandomElement(from: elements)!)
        
        self.properties = [
            ("Period", "\(info.period)", "mappin.and.ellipse.circle", Color.red),
            ("Block", "\(info.block)", "tablecells.badge.ellipsis", Color.green),
            ("Atomic Number", "\(info.number)", "number.circle", Color.orange),
            ("Atomic Weight", "\(info.atomicWeight) amu", "scalemass", Color.pink),
            ("Electron Affinity", "\((info.electron_affinity != nil) ? String(format: "%.1f",info.electron_affinity!) : "Not available") Kj/mol", "atom", Color.indigo),
            ("Category", "\(info.category)", "tray.full", Color.purple),
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
                    VStack(alignment: .leading, spacing: 20) { // Title block
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
                                    TitleBarHomePage(info: info)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                        .frame(width: 325, height: 350)
                                }
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    .gesture(
                        swipeGesture()
                    )
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.98)
                    .padding()
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
                                    if property.0 == "Block" {
                                        NavigationLink(
                                            destination: BlockView(selectedBlock: block),
                                            label: {
                                                PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                            }
                                        )
                                    } else if property.0 == "Period" {
                                        NavigationLink(
                                            destination: BlockView(selectedPeriod: Int(property.1)!),
                                            label: {
                                                PropertyCard(title: property.0, value: property.1, icon: property.2, color: property.3)
                                            }
                                        )
                                    } else if property.0 == "Atomic Number" {
                                        NavigationLink(
                                            destination: Details(info: info),
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
                    // Swiping down
                    withAnimation {
                        self.isTitleBarHidden = true
                    }
                } else {
                    // Swiping up
                    withAnimation {
                        self.isTitleBarHidden = false
                    }
                }
            }
    }
}

struct PropertyCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(colorScheme == .dark ? Color.black : Color.white)
                    .frame(width: 60, height: 60)
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(color)
            }
            .padding(8)
            .shadow(radius: 2)
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)
                    .fontWeight(.semibold)
                Text(value.capitalized(with: .current))
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
        .padding(10)
        .frame(width: 275, height: 75)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(colorScheme == .dark ? 0.2 : 1))
                .shadow(radius: 3)
        )
    }
}



#Preview {
    iPadHome()
}
