//
//  CheckBoxStyle.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return VStack(alignment: .leading) {
            
            HStack {
                configuration.label
                
                
                ZStack {
                    
                    Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(configuration.isOn ? Color("ColorMainDark") : .gray)
                        .font(.system(size: 20, weight: .regular, design: .default))
                    
                    Image(systemName: "square")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .font(.system(size: 20, weight: .regular, design: .default))
                }
                .padding(.leading, 10)
                
            }
            
            
            
            
        }
        .onTapGesture { configuration.isOn.toggle() }
        
    }
}
