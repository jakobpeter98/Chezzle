//
//  PuzzleViewModel.swift
//  Chezzle
//
//  Created by Jakob Peter on 17.05.23.
//
import SwiftUI
import Foundation



class PuzzleViewModel: ObservableObject {
    
    // Ui References
    @Published var currentPuzzle: Puzzle? = nil {
        didSet {
            // Automatically update all chessboard squares if the puzzle changes
            if (currentPuzzle?.id ?? "" != oldValue?.id ?? "") {
                updateSquares()
                moveIndex = 0
                score = puzzleRun?.score ?? -1
                streak = puzzleRun?.streak ?? -1
                tries = puzzleRun?.tries ?? -1
                solutionMoves = Converter.solutionToArray(solutionMovesString: currentPuzzle?.moves ?? "")
                firstSelection = true
                
                sourceIndex = Converter.uciToIndex(from: solutionMoves[moveIndex], colorToMove: colorToMove)
                targetIndex = Converter.uciToIndex(from: solutionMoves[moveIndex + 1], colorToMove: colorToMove)
                self.animateMove = true
                moveIndex += 2
//                self.animateMove = true
            }
        }
    }
    @Published var colorToMove: String = ""
    @Published var solutionMoves: [String] = []
    @Published var score: Int = 0
    @Published var streak: Int = 0
    @Published var tries: Int = 3
    @Published var squares: [Square] = []
    
    // Indices of Squares (0-63) representing a Move
    var sourceIndex: Int = 0
    var targetIndex: Int = 0
    
    // Animation variables
    @Published var animateMove = false
    @Published var animatePuzzleSolved = false
    
    // User Variables
    var userRating = 500
    var firstSelection: Bool = true
    
    
    // Data
    var puzzleRun: PuzzleRun?
    var moveIndex: Int = 0
    
    init() {
        puzzleRun = PuzzleRun(usrRating: userRating, onUpdate: {
            self.currentPuzzle = self.puzzleRun?.getNextPuzzle()
        })
        self.initSquares()
    }
    
    func initSquares() {
        for row in 0..<8 {
            for column in 0..<8{
                let color = (row + column) % 2 == 0 ? Color("ColorDark") : Color("ColorLight")
                let square = Square(piece: "", isSelected: false, color: color) { selectedSquare in
                    self.squareSelectionEvent(square: selectedSquare)
                }
                
                squares.append(square)
            }
        }
    }
    
    func updateSquares() {
        
        guard let puzzle = currentPuzzle else { print("no puzzle found")
            return }
        
        let fen = puzzle.fen
        let components = fen.components(separatedBy: " ")
        
        guard components.count >= 2 else { return }
        
        let fenBoard = components[0]
        colorToMove = components[1] == "w" ? "b": "w"
        
        var ranks = fenBoard.components(separatedBy: "/")
        
        guard ranks.count == 8 else { return }
        

        // Displaying the pieces order reversed if the color to move is black
        if (colorToMove == "b") {
            ranks.reverse()
            for i in 0..<ranks.count {
                ranks[i] = String(ranks[i].reversed())
            }
        }
        
        var squareIndex = 0
        
        for rank in ranks {
            for char in rank {
                if let digit = Int(String(char)) {
                    for _ in 1...digit {
                        squares[squareIndex].piece = ""
                        squares[squareIndex].isSelected = false
                        squareIndex += 1
                    }
                } else {
                    let pieceValue = Converter.fenPieceToImageName(from: String(char))
                    squares[squareIndex].piece = pieceValue
                    squares[squareIndex].isSelected = false
                    squareIndex += 1
                }
            }
        }
    }
    
    func squareSelectionEvent(square: Square) {
        guard !self.animateMove else {
            square.isSelected = false
            return
        }
        for i in squares.indices {
            if (squares[i] === square) {
                //make first selection
                if (square.isSelected) {
                    
                    if(firstSelection){
                        sourceIndex = i
                        firstSelection = false
                    }
                    //second selection
                    else {
                        if animateMove || animatePuzzleSolved{
                            square.isSelected = false
                            return
                        }
                        //dont select if source is empty, source is enemy color, or target is friendly color
                        if (squares[sourceIndex].piece.isEmpty || String(squares[sourceIndex].piece.last!) != colorToMove || String(square.piece.last ?? Character(" ")) == colorToMove){
                            squares[sourceIndex].isSelected = false
                            square.isSelected = false
                            firstSelection = true
                        } else {
                            let sourcePiece = squares[sourceIndex].piece
                            let targetPiece = square.piece
                            targetIndex = i
                            
                            
                            print(moveIndex)
                            print(solutionMoves.count - 1)
                            
                            let solutionSourceIndex = Converter.uciToIndex(from: solutionMoves[moveIndex], colorToMove: colorToMove)
                            
                            let solutionTargetindex = Converter.uciToIndex(from: solutionMoves[moveIndex + 1], colorToMove: colorToMove)
                            
                            if (sourceIndex == solutionSourceIndex && targetIndex == solutionTargetindex) {
                                squares[targetIndex].animateRight.toggle()
                                animateMove.toggle()
                                firstSelection = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){ [self] in
                                    self.nextMove()
                                }
                                
                            }else {
                                square.isSelected.toggle()
                                squares[sourceIndex].isSelected.toggle()
                                square.piece = targetPiece
                                squares[sourceIndex].piece = sourcePiece
                                self.puzzleRun?.failedTry()
                                squares[targetIndex].animateWrong.toggle()
                                tries = puzzleRun?.tries ?? -1
                                firstSelection = true
                                
                            }
                            
                            
                        }
                    }
                } else {
                    firstSelection = true
                }
                
            }
            
        }
        
        
    }
    
    func nextMove() {
        moveIndex += 2
        if moveIndex == solutionMoves.endIndex{
            animatePuzzleSolved.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.puzzleRun?.puzzleSolved()
            }
            return
        }
        sourceIndex = Converter.uciToIndex(from: solutionMoves[moveIndex], colorToMove: colorToMove)
        targetIndex = Converter.uciToIndex(from: solutionMoves[moveIndex + 1], colorToMove: colorToMove)
        animateMove.toggle()
        moveIndex += 2
    }
}



class Square: ObservableObject {
    @Published var piece: String
    @Published var isSelected: Bool = false {
        didSet {
            if oldValue != isSelected {
                handleSelectionChange?(self)
            }
        }
    }
    
    @Published var animateRight = false
    @Published var animateWrong = false
    
    var handleSelectionChange: ((Square) -> Void)?
    var color: Color
    
    init(piece: String, isSelected: Bool = false, color: Color = .clear, handleSelectionChange: ((Square) -> Void)? = nil) {
        self.handleSelectionChange = handleSelectionChange
        self.piece = piece
        self.isSelected = isSelected
        self.color = color
        
    }
}

class PuzzleRun: ObservableObject {
    let db: Database = Database.shared
    
    var isFirst = true
    
    var setNextPuzzle: (() -> Void)
    
    var nextPuzzle: Puzzle?
    var puzzles: [Puzzle]?
    
    var usrRating: Int
    var minRating: Int
    var maxRating: Int
    var tries: Int
    let multiplicator: Double
    var time: Double
    var score: Int
    var streak: Int
    
    //Later Update the Users Rating
    init(usrRating: Int = 500, onUpdate: @escaping () -> Void) {
        self.usrRating = usrRating
        self.setNextPuzzle = onUpdate
        minRating = usrRating + usrRating / 50
        maxRating = minRating + minRating / 10
        tries = 3
        multiplicator = 1.02
        time = 1
        score = 0
        streak = 0
        self.loadPuzzles(completion: {
            self.setNextPuzzle()
        })
    }
    
    func reset() {
        usrRating += score
        minRating = usrRating
        maxRating = minRating + minRating / 10
        tries = 3
        score = 0
        streak = 0
        setNextPuzzle()
    }
    
    func failedTry() {
        tries -= 1
        if tries == 0 {
            reset()
        }
        time += 1
    }
    
    func getNextPuzzle() -> Puzzle? {
        let result = nextPuzzle
        loadPuzzles(completion: nil)
        return result
    }
    
    func puzzleSolved() {
        print("puzzle solved maxRating: \(maxRating)")
        streak += 1
        time += [0.9,1.2,1.9].randomElement()! //Add Feature Later
//        let timePenalty = Int(time) / streak //..
        score += streak + (nextPuzzle?.rating ?? 500) - usrRating
        usrRating += score
        minRating = usrRating
        maxRating = Int(Double(nextPuzzle?.rating ?? 500) * multiplicator) + streak
        //setNextPuzzle()
    }
    
    func loadPuzzles(completion: (() -> Void)?) {
        db.loadPuzzles(minRating: minRating, maxRating: maxRating, limit: 20) { [weak self] puzzles in
            DispatchQueue.main.async {
                self?.puzzles = puzzles
                self?.nextPuzzle = puzzles.randomElement()
                completion?() // Call the completion handler when puzzles are loaded and nextPuzzle is updated
            }
        }
    }
}
