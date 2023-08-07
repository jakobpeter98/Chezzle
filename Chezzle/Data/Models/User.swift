//
//  User.swift
//  Chezzle
//
//  Created by Jakob Peter on 07.08.23.
//

import Foundation

struct User: Codable {
    
    let id: String
    let dateCreated: Date?
    
    var name: String?
    var rating: Int?
    
    var favourites: [PuzzleItem]?
    var history: [PuzzleItem]?
    
    var hasPremium: Bool?
    
    init(id: String) {
        self.id = id
        self.dateCreated = Date()
        self.name = "Unnamed User"
        self.favourites = []
        self.history = []
        self.rating = 500
        self.hasPremium = false
    }
    
}

struct PuzzleItem: Codable {
    let puzzleId: String
    let dateCreated: Date?
}
