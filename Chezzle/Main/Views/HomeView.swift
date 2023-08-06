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
        VStack(spacing: 1) {
            VStack(spacing: 3) {
                HStack(spacing: 4) {
                    Image("Logo")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, alignment: .center)
                        .shadow(color: .black,radius: 2,x: 1, y: 2)
                    
                }
                HStack(spacing: 4) {
                    Spacer()
                    ChezzleButton(text: "leave", imgName: "door.right.hand.open") {
                        userViewmodel.logOut()
                    }
                    .frame(width: 80, height: 40)
                    .padding(.vertical, 8)
                }
            }
            
            
            ScrollView {
                
                
                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Welcome to your chess-application with over 300k chess- puzzles and solutions")
                            .font(.custom("Noto Serif Vithkuqi", size: 25))
                            .fontWeight(.heavy)
                            .foregroundColor(AppColor.mainDark)
                        
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .shadow(radius: 3))
                    
                }
                
                
                VStack(alignment: .leading) {
                    
                    Text("Title")
                        .font(.custom("Noto Serif Vithkuqi", size: 30))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("ColorLight"))
                    
                    Text("Welcome to your chess-application with over 300k chess- puzzles and solutions chess-applic er 300k ch ess-application with ovic er 3zles and solutions chess-ap")
                        .font(.custom("Noto Serif Vithkuqi", size: 20))
                        .minimumScaleFactor(0.3)
                    
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .shadow(radius: 3))
            
                
                VStack(alignment: .leading) {
                    Text("Some News")
                        .font(.custom("Noto Serif Vithkuqi", size: 30))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("ColorLight"))
                    
                    Text("application with over 300k che chess- puutions chess-ap fdgfd gdfgfgf gdf")
                        .font(.custom(AppFontName.standard, size: 20))
                        .multilineTextAlignment(.leading)
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .shadow(radius: 3))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
