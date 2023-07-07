//
//  TagButton.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct TagButton: View {
    
    @State var isActive = false
    
    var text = "queens gambit"
    var color = Color("ColorMainLight")
    var actionColor = Color("ColorMain")
    var action: () -> Void
    
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.medium)
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .foregroundColor(isActive ? Color("ColorMain"): Color("ColorMainLight"))
            .padding(8)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isActive ? Color("ColorMain").opacity(0.3): Color("ColorMainLight").opacity(0.3))
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(isActive ? Color("ColorMain"): Color("ColorMainLight"),lineWidth: 1)
                        .padding(0.5)
                    
                })
            .onTapGesture {
                action()
                isActive.toggle()
            }
    }
}

struct TagButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TagButton(){
                //
            }
        }
        
    }
}
