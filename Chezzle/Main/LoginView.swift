//
//  LoginView.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var vm: LoginViewModel
    @State var email = ""
    @State var password = ""
    
    @State var loggedIn = false
    
    var body: some View{
        
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 16) {
                
                Spacer()
                HStack {
                    Image("Logo")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, alignment: .center)
                        .shadow(color: .black,radius: 2,x: 1, y: 2)
                }
                .padding(.bottom, 16)
                HStack {
                    TextField(text: $vm.usrMail) {
                        Text("Email...")
                            .foregroundColor(Color("ColorLightGray"))
                    }
                    .font(.title3)
                    .padding(4)
                    .padding(.horizontal, 6)
                    .frame(width: 250,height: 50)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(6)
                    .shadow(radius: 4)
                }
                
                HStack {
                    SecureField(text: $vm.usrPswd) {
                        Text("Password...")
                            .foregroundColor(Color("ColorLightGray"))
                        
                    }
                    .font(.title3)
                    .foregroundStyle(.black)
                    .padding(4)
                    .padding(.horizontal, 6)
                    .frame(width: 250,height: 50)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(6)
                    .shadow(radius: 4)
                }
                
                VStack(alignment: .leading){
                    
                    Toggle(isOn: $loggedIn) {
                        Text("Stay signed in?")
                    }
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .shadow(radius: 4)
                    .toggleStyle(CheckboxStyle())
                    
                    
                    
                }
                .frame(width: 250)
                
                
                ChezzleButton(text: "Sign in", imgName: "person.fill") {
                    //
                    vm.signIn()
                }
                .frame(width: 250, height: 50)
                
                Spacer()
                
                
            }
            .onAppear(){
                loggedIn = vm.rememberUser
                
            }
            .onChange(of: loggedIn, perform: { newValue in
                vm.rememberUser = newValue
            })
            .alert(vm.alertText, isPresented: $vm.showAlert, actions: {})
            //.rotation3DEffect(.degrees(vm.isLoggedIn ? 180 : 0), axis: (x: 0, y: -1, z: 0))
            //.animation(.easeOut(duration: 0.5), value: vm.isLoggedIn)
            Spacer()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(vm: LoginViewModel())
    }
}
