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
    
    @EnvironmentObject var vm: PuzzleViewModel
    @ObservedObject var vmLogin: LoginViewModel
    
    @State var isLoggedIn = false
    @State var showSettings = false
    
    init(vmLogin: LoginViewModel) {
        self.vmLogin = vmLogin
        self.isLoggedIn = vmLogin.isLoggedIn
    }
    
    var body: some View {
        GeometryReader{ geo in
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .contrast(0.1)
                .brightness(0.5)
            //.colorMultiply(currentView == .training ? Color("ColorLight") : Color("ColorMainLight"))
                .ignoresSafeArea()
            
            ZStack {
                VStack {
                    HStack(alignment: .bottom, spacing: 0){
                        if isLoggedIn {
                            ChezzleTabBar().environmentObject(vm)
                                .transition(.move(edge: .trailing))
                        }
                        else {
                            LoginView(vm: vmLogin)
                                .transition(.move(edge: .trailing))
                        }
                        
                    }
                    .onAppear {
                        isLoggedIn = vmLogin.isLoggedIn
                    }
                    .onChange(of: vmLogin.isLoggedIn) { newValue in
                        withAnimation(.interpolatingSpring(stiffness: 160, damping: 14.3)){
                            isLoggedIn = newValue
                        }
                
                    
                    
                }
                
                
                
            }
            
                
            }
        }
        
    }
}
    
    
    
    //struct DisplayBottom: View {
    //    @EnvironmentObject var vm: LoginViewModel
    //    @Binding var currentView: ShowView
    //    @Binding var showSettings: Bool
    //    var body: some View {
    //        HStack(alignment: .center, spacing: 8){
    //            ChezzleButton(imgName: "arrowshape.turn.up.left.fill", action: {
    //                if currentView == .root{
    //                    vm.logOut()
    //                } else {
    //                    withAnimation(.interpolatingSpring(stiffness: 160, damping: 14.3)) {
    //                        currentView = .root
    //                    }
    //
    //                }
    //            })
    //            .frame(width: 50,height: 50)
    //            ChezzleButton(imgName: "gearshape.fill", action: {
    //                withAnimation(.interpolatingSpring(stiffness: 150, damping: 14.3)){
    //                    showSettings.toggle()
    //                }
    //
    //            })
    //            .frame(width: 50,height: 50)
    //
    //        }
    //        .background(Color(.white).opacity(0.3))
    //
    //    }
    //}
    
    struct MenuView_Previews: PreviewProvider {
        
        static var previews: some View {
            let vm = LoginViewModel()
            MenuView(vmLogin: vm).environmentObject(PuzzleViewModel())
        }
    }
    
    /*VStack {
     
     Spacer()
     
     HStack(alignment: .center, spacing: 16) {
     
     VStack(alignment: .center,spacing: 0){
     ChezzleButton(imgName: "puzzlepiece.extension.fill", action: {
     withAnimation(.interpolatingSpring(stiffness: 160, damping: 14.3)){
     currentView = .puzzle
     
     }
     }
     )
     .scaledToFit()
     .frame(maxWidth: geo.size.width / 4)
     .foregroundColor(Color.white)
     
     Text("Puzzle")
     .font(.system(size: 25, design: .rounded))
     .foregroundColor(Color("ColorMainDark"))
     .multilineTextAlignment(.center)
     .padding(3)
     }
     
     VStack(alignment: .center,spacing: 0){
     ChezzleButton(imgName: "dumbbell.fill",
     action: {
     withAnimation(.interpolatingSpring(stiffness: 200, damping: 16.6)){
     currentView = .training
     
     }                                        }
     )
     .scaledToFit()
     .frame(maxWidth: geo.size.width / 4)
     .foregroundColor(Color.white)
     Text("Training")
     .font(.system(size: 25, design: .rounded))
     .foregroundColor(Color("ColorMainDark"))
     .multilineTextAlignment(.center)
     .padding(3)
     }
     
     
     VStack(alignment: .center,spacing: 0){
     ChezzleButton(imgName: "clock.fill", action: {
     }
     )
     .scaledToFit()
     .frame(maxWidth: geo.size.width / 4)
     .foregroundColor(Color.white)
     Text("History")
     .font(.system(size: 25, design: .rounded))
     .foregroundColor(Color("ColorMainDark"))
     .multilineTextAlignment(.center)
     .padding(3)
     }
     
     }
     
     }
     .frame(width: geo.size.width)
     .transition(.asymmetric(insertion: .push(from: .leading), removal: .push(from: .trailing)))
     */
