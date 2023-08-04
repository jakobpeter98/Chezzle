//
//  MenuView.swift
//  Chezzle
//
//  Created by Jakob Peter on 24.05.23.
//

import SwiftUI

enum ShowView {
    case root
    case login
    case puzzle
    case training
}

struct MenuView: View {
    
    @EnvironmentObject var vm : PuzzleViewModel
    @EnvironmentObject var usrViewModel : UserViewModel
    
    @State var isLoggedIn = false
    @State var showSettings = false
    
//    init() {
//        self.isLoggedIn = usrViewModel.isLoggedIn
//    }
    
    var body: some View {
        GeometryReader{ geo in
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .contrast(0.1)
                .brightness(0.5)
                .colorMultiply(AppColor.mainLight)
                .ignoresSafeArea()
            
            ZStack {
                VStack {
                    HStack(alignment: .bottom, spacing: 0){
                        if isLoggedIn {
                            ChezzleTabBar()
                                .environmentObject(vm)
                                .transition(.opacity)
                        }
                        else {
                            LoginView(vm: usrViewModel)
                                .transition(.opacity)
                        }
                        
                    }
                    .onAppear {
                        isLoggedIn = usrViewModel.isLoggedIn
                    }
                    .onChange(of: usrViewModel.isLoggedIn) { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            isLoggedIn = newValue
                        }
                
                    
                    
                }
                
                
                
            }
            
                
            }
        }
        
    }
}
    
    
    struct MenuView_Previews: PreviewProvider {
        
        static var previews: some View {
            MenuView()
                .environmentObject(PuzzleViewModel())
                .environmentObject(UserViewModel())
        }
    }
    
