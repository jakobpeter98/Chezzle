//
//  ChezzleApp.swift
//  Chezzle
//
//  Created by Jakob Peter on 09.05.23.
//
import Firebase
import SwiftUI

@main
struct ChezzleApp: App {
    
    //Initializing
    let db: Database
    let vmLogin: LoginViewModel
    let vm: PuzzleViewModel
   
    init() {
        
        FirebaseApp.configure()
        
        db = Database.shared
        vmLogin = LoginViewModel()
        vm = PuzzleViewModel()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MenuView(vmLogin: vmLogin)
                .environmentObject(vm)
                
        }
    }
}
