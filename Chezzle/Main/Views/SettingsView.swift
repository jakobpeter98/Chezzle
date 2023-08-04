//
//  SettingsView.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct SettingsView: View {
    @State var toggle1 = true
    @State var toggle2 = true
    @State var toggle3 = true
    @State var toggle4 = false
    @State var toggle5 = "Luis"
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0){
                
                Text("Settings")
                    .font(.largeTitle)
                    .padding(16)
                    .padding(.leading, 16)
                    .foregroundColor(.white)

                
                HStack(alignment: .center, spacing: 0){
                    List {
                        SettingsSection(title: "Profil", img: {
                                Image(systemName:"person.fill")
                            }){
                                TextField("Name", text: $toggle5)
                                TextField("Name", text: $toggle5)
                        }
                        
                        
                        SettingsSection(title: "This is a Section") {
                            
                            Toggle(isOn: $toggle1) {
                                Text("adjust here:")
                            }
                            Toggle(isOn: $toggle2) {
                                Text("adjust here:")
                            }
                            
                        }
                        
                        SettingsSection(title: "This is a Section") {
                            
                            TextField("Name", text: $toggle5)
                            
                            
                        }
                        
                        
                        SettingsSection(title: "This is a Section") {
                            Text("This is a Section")
                                .padding(.vertical, 8)
                            
                            Toggle(isOn: $toggle3) {
                                Text("adjust here:")
                            }
                        }
                        .listRowBackground(Color(.white))
                        
                        SettingsSection(title: "This is a Section") {
                            Text("Important:")
                                .font(.title3)
                                .padding(.vertical, 8)
                            
                            Toggle(isOn: $toggle4) {
                                Text("adjust here:")
                            }
                            
                            
                        }
                        
                        SettingsSection(title: "This is a Section") {
                            Toggle(isOn: $toggle1) {
                                Text("adjust here:")
                            }
                            
                        }
                        
                        ChezzleButton(bgColor: Color.red, fgColor: Color.white, text: "Delete Account", actionColor: Color.gray) {
                            //
                            
                        }
                        .listRowBackground(Color.clear
                        )
                        .frame(height: 40, alignment: .leading)
                        .padding(.vertical, 8)
                        
                    }
                    .scrollIndicators(.visible)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(Color.white)
                    
                    
                    
                }
            }
        }
    
}


struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color("ColorMainDark")
            SettingsView()
        }
    }
}
