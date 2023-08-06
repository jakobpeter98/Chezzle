//
//  Values.swift
//  Chezzle
//
//  Created by Jakob Peter on 04.08.23.
//

import SwiftUI

struct AppColor {
    static let main = Color("ColorMain")
    static let mainLight = Color("ColorMainLight")
    static let mainDark = Color("ColorMainDark")
    static let light = Color("ColorLight")
    static let dark = Color("ColorDark")
}

struct AppFontName {
    static let standard = "Noto Serif Vithkuqi"
    static let title = "Noto Serif Vithkuqi"
    static let title2 = "Noto Serif Vithkuqi"
    static let caption = "Noto Serif Vithkuqi"
}

enum LibraryItem : CaseIterable {
    case search, history, favourites
    
    var img : Image {
        switch self {
        case .search: return Image(systemName: "magnifyingglass")
        case .history: return Image(systemName: "clock.arrow.circlepath")
        case .favourites: return Image(systemName: "heart")
        }
    }
}

enum TabBarItem : CaseIterable {
    case home, puzzle, library, settings
    
    @ViewBuilder var view: some View {
        switch self {
        case .home : HomeView()
        case .puzzle: BoardView()
        case .library: LibraryView()
        case .settings: SettingsView()
        }
    }
    
    var title: String {
        switch self {
        case .home: return "home"
        case .puzzle: return "puzzle"
        case .library: return "library"
        case .settings: return "settings"
        }
    }
    
    var imgName: String {
        switch self {
        case .home: return "house.fill"
        case .puzzle: return "puzzlepiece.extension.fill"
        case .library: return "book.closed.fill"
        case .settings: return "gearshape.fill"
        }
    }
    
    var index: Int {
        switch self {
        case .home: return 0
        case .puzzle: return 1
        case .library: return 2
        case .settings: return 3
        }
    }
    
}
