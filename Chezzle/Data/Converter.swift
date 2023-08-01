//
//  Helper.swift
//  Chezzle
//
//  Created by Jakob Peter on 24.05.23.
//

import Foundation

class Converter {
    
    static func indexToUci(squareIndex: Int, colorToMove: String) -> String {
        let rank = squareIndex / 8 // Divide squareIndex by 8 to get the rank (row)
        let file = squareIndex % 8 // Take the remainder of squareIndex divided by 8 to get the file (column)
        
        let rankIndex = (colorToMove == "w") ? 7 - rank : rank // Adjust the rank index based on the color to move
        let fileIndex = (colorToMove == "w") ? file : 7 - file // Adjust the file index based on the color to move
        
        let uci = "\(indexToChar(from: fileIndex))\(rankIndex + 1)" // Concatenate the file and rank characters to form the UCI notation
        
        return uci
    }

    static func solutionToArray(solutionMovesString: String) -> [String] {
        let moves = solutionMovesString.components(separatedBy: " ")
        var array: [String] = []
        
        for move in moves {
            let fromSquare = String(move.prefix(2))
            var toSquare = ""
            if move.count > 4 {
                toSquare = String(String(move.suffix(3)).prefix(2))
            } else {
                toSquare = String(move.suffix(2))
            }
            
            
            array.append(fromSquare)
            array.append(toSquare)
        }
        
        return array
    }
    
    static func uciToIndex(from position: String, colorToMove: String) -> Int {
        let file = position[position.startIndex]
        let rank = position[position.index(after: position.startIndex)]
        
        let fileIndex = charToIndex(from: file)
        let rankIndex = (Int(String(rank)) ?? 1) - 1
        
        let squareIndex: Int
        if colorToMove == "b" {
            squareIndex = rankIndex * 8 + (7 - fileIndex)
        } else {
            squareIndex = (7 - rankIndex) * 8 + fileIndex
        }
        
        return squareIndex
    }

    static func charToIndex(from char: Character) -> Int {
        switch char {
        case "a": return 0
        case "b": return 1
        case "c": return 2
        case "d": return 3
        case "e": return 4
        case "f": return 5
        case "g": return 6
        case "h": return 7
        default: return 0
        }
    }
    
    static func indexToChar(from index: Int) -> String {
        switch index {
        case 0: return "a"
        case 1: return "b"
        case 2: return "c"
        case 3: return "d"
        case 4: return "e"
        case 5: return "f"
        case 6: return "g"
        case 7: return "h"
        default: return ""
        }
    }
    
    static func fenPieceToImageName(from str: String) -> String {
        switch str {
        case "P": return "pawn_w"
        case "N": return "knight_w"
        case "B": return "bishop_w"
        case "R": return "rook_w"
        case "Q": return "queen_w"
        case "K": return "king_w"
        case "p": return "pawn_b"
        case "n": return "knight_b"
        case "b": return "bishop_b"
        case "r": return "rook_b"
        case "q": return "queen_b"
        case "k": return "king_b"
        default: return ""
        }
    }
    
    static func toSeparatedString(from: String) -> String {
        let words = from.components(separatedBy: " ")
        return words.joined(separator: ", ")
    }
    
    static func openingTagToString(from openingTag: String) -> String {
        let words = openingTag.components(separatedBy: " ")
        let camelCaseWords = words.map { word -> String in
            let components = word.components(separatedBy: "_")
            let capitalizedComponents = components.map { $0.capitalized }
            return capitalizedComponents.joined()
        }
        return camelCaseWords.joined(separator: ", ")
    }
}
