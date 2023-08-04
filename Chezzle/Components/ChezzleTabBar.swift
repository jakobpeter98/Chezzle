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
        case .home : HomeView()
        case .puzzle: BoardView()
        case .training: Text("training")
        case .settings: SettingsView()
        }
    }
    
    var title: String {
        switch self {
        case .home: return "home"
        case .puzzle: return "puzzle"
        case .training: return "training"
        case .settings: return "settings"
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
    
    var index: Int {
        switch self {
        case .home: return 0
        case .puzzle: return 1
        case .training: return 2
        case .settings: return 3
        }
    }
    
}

struct TabIcon: View {
    
    var imgName: String
    var bgColor = Color("ColorMainDark")
    var fgColor = Color.white
    var body: some View {
        GeometryReader { geo in
            ZStack {
                bgColor
                Image(systemName: imgName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(fgColor)
                    .padding(geo.size.width / 8)
            }
            .frame(width: geo.size.width)
        }
        
    }
}

struct ChezzleTabBar: View {
    
    @EnvironmentObject var vm: PuzzleViewModel
    
    @State var selection: TabBarItem = .home
    @State var lastSelection: TabBarItem = .settings
    
    var pushTrailing: Bool {
        if lastSelection.index < selection.index {
            return true
        } else {
            return false
        }
        
    }
    
    var bgColor : Color {
        switch selection {
        case .home:
            return Color("ColorMainLight")
        case .puzzle:
            return Color("ColorMainLight")
        case .training:
            return Color("ColorLight")
        case .settings:
            return Color("ColorDark")
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                Image("BackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .contrast(0.1)
                    .brightness(0.5)
                    .colorMultiply(bgColor)
                
                ZStack {
                    
                    selection.view
                        .shadow(radius: 0)
                        .shadow(radius: 3)
                        .padding(.bottom, geo.size.height / 10)
                        .padding(6)
                        .frame(width: geo.size.width)
                        .transition(.asymmetric(insertion: .push(from: pushTrailing ? .trailing : .leading), removal: .opacity))
                    
                    VStack {
                        Spacer()
                        HStack(spacing: 0) {
                            ForEach(TabBarItem.allCases, id: \.self) { item in
                                VStack(spacing: 0) {
                                    
                                    if selection == item {
                                        Text(item.title)
                                            .font(.custom("Noto Serif Vithkuqi", size: 20))
                                            .frame(width: geo.size.width / 4)
                                            .foregroundColor(Color("ColorMain"))
                                            .transition(.scale)
                                            
                                    }
                                    
                                    TabIcon(imgName: item.imgName, bgColor: Color.clear, fgColor: selection == item ? Color("ColorMain") : Color.white)
                                        .onTapGesture {
                                            
                                            lastSelection = selection
                                            selection = item
                                            
                                        }
                                        .padding(-8)
                                        .rotation3DEffect(.degrees(selection == item ? 30 : 0), axis: (x: 1, y: 0, z: 0))
                                        .offset(y: selection == item ? -6 : 0)
                                        
                                    
                                }
                                .padding(8)
                                .frame(width: geo.size.width / 4)
                                .background(
                                    Color("ColorMainDark")
                                        .shadow(
                                            .inner(color: selection == item ? .black : Color("ColorMainDark"), radius: 3, x: 0, y: -1)
                                        )
                                        )
                                .zIndex(selection == item ? 2 : 1)
                                .animation(.interpolatingSpring(stiffness: 200, damping: 20), value: selection)
                                
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height / 10)
                        .background(Color("ColorMainDark"))
                        
                    }
                }
            }
            .frame(width: geo.size.width)
            
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.3), value: selection)
            
            
            
            
            
        }
        
    }
    
}

struct ChezzleTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ChezzleTabBar(selection: .puzzle).environmentObject(PuzzleViewModel())
    }
}
