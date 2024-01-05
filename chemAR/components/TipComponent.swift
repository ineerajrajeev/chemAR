//
//  TipComponent.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 08/12/23.
//

import SwiftUI
import TipKit

struct ElementTip: Tip {
    let element: ElementInfo
    let id = UUID()
    var title: Text {
        Text("Tip")
    }
    var message: Text? {
        Text("\(element.name) is a \(element.category).")
    }
    var image: Image? {
        Image(systemName: "atom")
    }
}
