import SwiftUI

enum Blocks: String, CaseIterable {
    case all = "*"
    case s = "s"
    case p = "p"
    case d = "d"
    case f = "f"
    
    var periods: [Int] {
        switch self {
            case .all: return [0, 1, 2, 3, 4, 5, 6, 7, 8]
            case .s: return [0, 1, 2, 3, 4, 5, 6, 7, 8]
            case .p: return [0, 2, 3, 4, 5, 6, 7]
            case .d: return [0, 4, 5, 6, 7]
            case .f: return [0, 6, 7]
        }
    }
}

struct BlockView: View {
    @State private var searchTerm = ""
    @State var selectedBlock: Blocks = .all
    @State var selectedPeriod: Int = 0

    var filteredElements: [String: ElementInfo] {
        if selectedBlock == .all { // If block selected to all
            guard !searchTerm.isEmpty else { return elements } // If search term is empty return all elements
            return elements.filter { // If search term is not empty
                $0.value.name.localizedCaseInsensitiveContains(searchTerm) ||
                $0.value.symbol.localizedCaseInsensitiveContains(searchTerm) ||
                String($0.value.number).localizedCaseInsensitiveContains(searchTerm)
            }
        } else { // If particular block is selected
            let blockElements = Dictionary(uniqueKeysWithValues:
                elements.filter { filterElementsByBlock(block: selectedBlock.rawValue).keys.contains($0.key) }
            ) // Filter the elements by block
            guard !searchTerm.isEmpty else { return blockElements } // Check if searc term is empty
            return blockElements.filter {
                $0.value.name.localizedCaseInsensitiveContains(searchTerm) ||
                $0.value.symbol.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    var filteredByPeriod: [String: ElementInfo] {
        if selectedPeriod == 0 { // If All Periods is selected
            return filteredElements
        } else {
            return filteredElements.filter { $0.value.period == selectedPeriod }
        }
    }
    
    var sortedElements: [ElementInfo] {
        filteredByPeriod.values.sorted { $0.number < $1.number }
    }

    var body: some View {
        VStack {
            HStack {
                Text(selectedBlock.rawValue == "*" ? "All Blocks" : "\(selectedBlock.rawValue.uppercased()) Block")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            SearchBar(searchTerm: $searchTerm)
            
            HStack {
                Picker(selection: $selectedBlock, label: Text("Block")) {
                    ForEach(Blocks.allCases, id: \.self) {
                        if ($0.rawValue == "*") {
                            Text("All Blocks")
                        } else {
                            Text("\($0.rawValue.uppercased()) Block")
                        }
                    }
                }
                .pickerStyle(.automatic)
                .padding()
                
                Spacer()
                
                Picker(selection: $selectedPeriod, label: Text("Block")) {
                    ForEach(selectedBlock.periods, id: \.self) {
                        if ($0 == 0) {
                            Text("All Periods")
                        } else {
                            Text("\($0) Period")
                        }
                    }
                }
                .pickerStyle(.automatic)
                .padding()
                
                Button("Clear", action: {
                    selectedBlock = .all
                    selectedPeriod = 0
                })
            }
            
            List(sortedElements, id: \.name) { element in
                NavigationLink(destination: Details(info: element)) {
                    ListItem(info: element)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(blockColor(element.block))
                        )
                }
                .contextMenu(ContextMenu(menuItems: {
                    NavigationLink(destination: Details(info: element)) {
                        Text("Details View")
                    }
                    NavigationLink(destination: ARViewContainer(info: element)) {
                        Text("AR View")
                    }
                }))
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .padding()
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

struct SearchBar: View {
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            TextField("Search element", text: $searchTerm)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading, .trailing])
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView()
    }
}
