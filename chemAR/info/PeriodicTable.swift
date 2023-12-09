//
//  PeriodicTable.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct PeriodicTable: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var searchText = ""
    @State private var selectedElement: ElementInfo?

    var body: some View {
            if horizontalSizeClass == .compact {
                Text("Error: Please use the horizontal orientation.")
            } else {
                Image(.periodicTable)
                    .resizable()
                    .scaledToFit()
            }
        }
}

#Preview {
    PeriodicTable()
}
