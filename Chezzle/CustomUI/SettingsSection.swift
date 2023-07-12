//
//  SettingsSection.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct SettingsSection<Content> : View where Content : View{
    var title: String
    var img: () -> Image = {Image(systemName: "star.fill")}
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        Section {
            content()
        } header: {
            HStack(alignment: .firstTextBaseline, spacing: 4){
                
                img()
                
                Text(title)
                    .font(.subheadline)
                
            }
        }
        .listRowBackground(Rectangle().fill(.ultraThinMaterial))
        
    }
}

struct SettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        List{
            SettingsSection(title: "CustomSection") {
                Text("conf some")
            }
        }
    }
}
