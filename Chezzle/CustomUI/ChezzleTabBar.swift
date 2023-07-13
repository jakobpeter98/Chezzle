//
//  ChezzleTabBar.swift
//  Chezzle
//
//  Created by Jakob Peter on 12.07.23.
//

import SwiftUI

enum TabBarItem : CaseIterable {
    case home, puzzle, training, settings
    
    @ViewBuilder var view: some View {
        switch self {
        case .home : Text("Home")
        case .puzzle: BoardView()
        case .training: Text("training")
        case .settings: Text("settings")
        }
    }
    
    var imgName: String {
        switch self {
        case .home: return "house.fill"
        case .puzzle: return "puzzlepiece.extension.fill"
        case .training: return "dumbbell.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

struct TabIcon: View {
    
    var imgName: String
    var backGroundColor = Color("ColorMainDark")
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                backGroundColor
                Image(systemName: imgName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .padding(geo.size.width / 8)
            }
            .frame(width: geo.size.width)
        }
        
    }
}

struct ChezzleTabBar: View {
    
    @EnvironmentObject var vm: PuzzleViewModel
    
    @State var selection: TabBarItem = .home
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                Image("BackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .contrast(0.1)
                    .brightness(0.5)
                    .colorMultiply(selection == .training ? Color("ColorLight") : Color("ColorMainLight"))
                
                ZStack {
                 
                    selection.view
                        .transition(.slide)
                        .shadow(radius: 0)
                        .frame(width: geo.size.width)
                        .shadow(radius: 3)
                        .padding(.bottom, geo.size.height / 10)
                    
                    VStack {
                        Spacer()
                        HStack(spacing: 0) {
                            ForEach(TabBarItem.allCases, id: \.self) { item in
                                TabIcon(imgName: item.imgName, backGroundColor: selection == item ? .gray : Color("ColorMainDark"))
                                    .onTapGesture {
                                        selection = item
                                    }
                                
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height / 10)
                    }
                }
            }
            .frame(width: geo.size.width)
            .ignoresSafeArea()
            .animation(.interpolatingSpring(stiffness: 200, damping: 20), value: selection)
            
            
            
            
            
        }
        
    }
}

struct ChezzleTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ChezzleTabBar(selection: .puzzle).environmentObject(PuzzleViewModel())
    }
}
