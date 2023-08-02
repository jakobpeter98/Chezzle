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
    @StateObject var vmLogin = UserViewModel()
    @StateObject var vm = PuzzleViewModel()
   
    init() {
        FirebaseApp.configure()
        db = Database.shared
    }
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(vmLogin)
                .environmentObject(vm)
        }
    }
}
