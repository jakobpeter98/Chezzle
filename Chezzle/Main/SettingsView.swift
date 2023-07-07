//
//  SettingsView.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var show: Bool
    @State var toggle1 = true
    @State var toggle2 = true
    @State var toggle3 = true
    @State var toggle4 = false
    @State var toggle5 = "Luis"
    
    @State var animate = true
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(radius: 3)
            
            VStack(alignment: .leading, spacing: 0){
                
                Text("Settings")
                    .font(.largeTitle)
                    .padding(16)
                    .padding(.leading, 16)
                    .foregroundColor(Color("ColorMainDark"))
                
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
                        
                        
                        Section("This is a Section") {
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
                    .background(Rectangle()
                        .fill(Gradient(colors:[Color(.white),Color("ColorMainLight").opacity(0.2)]
                                      )
                        )
                    )
                    .foregroundColor(Color("ColorMainDark"))
                    
                    
                    
                }
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)){
                            show.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "chevron.compact.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 16)
                            .foregroundColor(Color("ColorMainDark"))
                            .padding(16)
                    }
                    .offset(y: animate ? 2: 0)
                    .animation(.easeOut(duration: 1).repeatForever(autoreverses: true).delay(0.5), value: animate)
                    
                    Spacer()
                }
                .padding(.bottom, 64)
                .background(Color.white.shadow(color: .black, radius: 3))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        animate.toggle()
                    }
                    
                }
            }
        }
        .offset(y: 64)
        .ignoresSafeArea()
        
        
        
    }
    
}


struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var lol = true
        SettingsView(show: $lol)
    }
}
