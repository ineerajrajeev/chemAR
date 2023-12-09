
import SwiftUI

struct Details: View {
    @Environment(\.colorScheme) var colorScheme
    let info: ElementInfo
    
    var body: some View {
        VStack {
            if UIDevice.isiPad {
                iPadDetails(info: info)
            } else {
                iPhoneDetails(info: info)
            }
        }
        .padding()
    }
}

#Preview {
    Details(info: mockData)
}
