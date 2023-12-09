//
//  deviceCheck.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import Foundation
import SwiftUI

extension UIDevice {
    static var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
