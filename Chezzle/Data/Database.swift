//
//  Database.swift
//  Chezzle
//
//  Created by Jakob Peter on 19.05.23.
//

import Firebase
import FirebaseFirestore

struct Puzzle {
    let id: String
    let fen: String
    let moves: String
    let rating: Int

    init?(document: DocumentSnapshot) {
        guard let data = document.data(),
              let id = data["id"] as? String,
              let fen = data["fen"] as? String,
              let moves = data["moves"] as? String,
              let rating = data["rating"] as? Int
        else {
            return nil
        }

        self.id = id
        self.fen = fen
        self.moves = moves
        self.rating = rating
    }
}

class Database {
    static let shared = Database()

    private let db: Firestore

    private init() {
        db = Firestore.firestore()
    }

    func loadPuzzles(minRating: Int, maxRating: Int, limit: Int, completion: @escaping ([Puzzle]) -> Void) {
        let query = db.collection("puzzles")
                        .whereField("rating", isGreaterThanOrEqualTo: minRating)
                        .whereField("rating", isLessThanOrEqualTo: maxRating)
                        .limit(to: limit)

        query.getDocuments { snapshot, error in
            guard let snapshot = snapshot else {
                // Handle the error
                print("Error fetching documents: \(error as Any)")
                return
            }

            // Process the fetched documents
            let puzzles = snapshot.documents.compactMap { Puzzle(document: $0) }

            // Call the completion handler with the fetched puzzles
            completion(puzzles)
        }
    }
}

