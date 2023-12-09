//
//  tab2.swift
//  App
//
//  Created by Neeraj Shetkar on 07/12/23.
//

import SwiftUI

struct allElementsView: View {
    @State private var searchTerm = ""
    let allElements = Array(elements.values)
    
    var filteredElements: [ElementInfo] {
        guard !searchTerm.isEmpty else { return allElements }
        return allElements.filter {
            $0.name.localizedCaseInsensitiveContains(searchTerm) ||
            $0.symbol.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredElements, id: \.name) { element in
                NavigationLink(destination: Details(info: element)) {
                    ListItem(info: element)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(blockColor(element.block))
                        )
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("All Elements")
            .searchable(text: $searchTerm, placement: .automatic, prompt: "Search element")
        }
    }
    
    func blockColor(_ block: String) -> Color {
        switch block {
        case "s": return Color("sblock_background")
        case "p": return Color("pblock_background")
        case "d": return Color("dblock_background")
        case "f": return Color("fblock_background")
        default: return Color.white
        }
    }
}



#Preview {
    allElementsView()
}
