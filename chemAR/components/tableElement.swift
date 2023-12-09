//
//  tableElement.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import SwiftUI

struct tableElement: View {
    let info: ElementInfo
    var body: some View {
        VStack {
            HStack {
                Text("\(info.number)")
                Spacer()
                Text("\(String(format: "%.3f", info.atomicWeight))")
            }
            Spacer()
            Text("\(info.symbol)")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            HStack {
                Text("\(info.name)")
            }
        }
        .padding()
    }
}

#Preview {
    tableElement(info: mockData)
}
