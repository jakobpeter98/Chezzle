//
//  HomeView.swift
//  Chezzle
//
//  Created by Jakob Peter on 02.08.23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewmodel : UserViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 4) {
                    Image("Logo")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, alignment: .center)
                        .shadow(color: .black,radius: 2,x: 1, y: 2)
                    
                        .saturation(0.3)
                        .opacity(0.8)
                    
                }
                Text("Welcome to your chess-application with over 300k chess- puzzles and solutions")
                    .font(.custom("Noto Serif Vithkuqi", size: 20))
                    .opacity(0.8)
                    .minimumScaleFactor(0.3)
                
                
                HStack(spacing: 16) {
                    Spacer()
                    ChezzleButton(text: "leave", imgName: "door.right.hand.open") {
                        userViewmodel.logOut()
                    }
                    .frame(width: 100, height: 50)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(6)
            
            VStack(alignment: .leading) {
                
                Text("Title")
                    .font(.custom("Noto Serif Vithkuqi", size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("ColorLight"))
                
                Text("Welcome to your chess-application with over 300k chess- puzzles and solutions chess-applic er 300k ch ess-application with ovic er 3zles and solutions chess-ap")
                    .font(.custom("Noto Serif Vithkuqi", size: 20))
                    .minimumScaleFactor(0.3)
                    .opacity(0.8)
                
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text("Some News")
                    .font(.custom("Noto Serif Vithkuqi", size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("ColorLight"))
                
                Text("application with over 300k che chess- puutions chess-ap fdgfd gdfgfgf gdf")
                    .font(.custom("Noto Serif Vithkuqi", size: 20))
                    .minimumScaleFactor(0.3)
                    .opacity(0.8)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(6)
            
            
        }
        .padding()
        
        
        
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
