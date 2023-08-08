//
//  BoardView.swift
//  Chezzle
//
//  Created by Jakob Peter on 09.05.23.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var viewModel: PuzzleViewModel
    @State var animate = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    
                    
                    
                    DisplayTop()
                        
                    
                    Board(squares: viewModel.squares)
                        .shadow(radius: 0)
                        .frame(height: geo.size.width)
                    
                    
                    
                    DisplayBottom()
                        .padding(8)
                        .frame(width: geo.size.width,height: geo.size.height / 10)
                        .background(Color("ColorOffWhite"), in: RoundedRectangle(cornerRadius: 6))
                        .background( Color("ColorOffWhite").padding(.bottom, 6))
                    
                  
                }
                Spacer()
                
            }
            
        }

        
    }
}



struct Board: View {
    @EnvironmentObject var viewModel: PuzzleViewModel
    @State var squares: [Square]
    @State var animate: Bool = false
    @State var puzzleSolvedAnimation = true
    @State var animatedPiece = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 0) {
                    ForEach(0..<8) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<8) { column in
                                let index = row * 8 + column
                                let square = squares[index]
                                
                                SquareView(square: square)
                            }
                        }
                    }
                }
                
                
                if viewModel.animateMove {
                    Image(animatedPiece)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 4)
                        .frame(width: geo.size.width / 8, height: geo.size.width / 8)
                        .position(
                            x: geo.size.width / 16 + CGFloat(viewModel.sourceIndex % 8) * (geo.size.width / 8),
                            y: geo.size.width / 16 + CGFloat(viewModel.sourceIndex / 8) * (geo.size.width / 8)
                        )
                        .offset(x: animate ? CGFloat(viewModel.targetIndex % 8 - viewModel.sourceIndex % 8) * (geo.size.width / 8) : 0,
                                y: animate ? CGFloat(viewModel.targetIndex / 8 - viewModel.sourceIndex / 8) * (geo.size.width / 8) : 0)
                        .onAppear {
                            animatedPiece = squares[viewModel.sourceIndex].piece
                            squares[viewModel.sourceIndex].piece = ""
                            withAnimation(.easeInOut(duration: 0.5)){
                                animate = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                //deselect
                                squares[viewModel.sourceIndex].isSelected = false
                                squares[viewModel.targetIndex].isSelected = false
                                squares[viewModel.targetIndex].piece = animatedPiece
                                animatedPiece = ""
                                viewModel.animateMove = false
                                animate = false
                            }
                        }
                        
                }
                
                PuzzleSolvedCard(show: $viewModel.animatePuzzleSolved)
                
            }
        }
    }
}

struct SquareView: View {
    @EnvironmentObject var viewModel: PuzzleViewModel
    @ObservedObject var square: Square
    
    @State var animateRight = false
    @State var animateWrong = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(square.color)
                .border(square.isSelected ? Color("ColorMainLight") : Color.clear, width: 3)
                .animation(.easeIn(duration: 0.2), value: square.isSelected)
            
            if animateRight{
                Rectangle()
                    .fill(square.color)
                    .border(Color.green, width: 3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            square.animateRight.toggle()
                        }
                    }
                
            }
            
            if animateWrong{
                Rectangle()
                    .fill(square.color)
                    .colorMultiply(animateWrong ? Color.red: Color.clear)
                    .animation(.easeOut(duration: 0.3), value: square.animateWrong)
                    .border(Color.red, width: 3)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            square.animateWrong.toggle()
                        }
                    }
                
            }
            
            
            if !square.piece.isEmpty {
                Image(square.piece)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 4)
            }
        }
        .onChange(of: square.animateRight, perform: { newValue in
            withAnimation(.easeInOut(duration: 0.1)){
                animateRight = newValue
                
            }
        })
        .onChange(of: square.animateWrong, perform: { newValue in
            withAnimation(.easeOut(duration: 0.2).repeatCount(4, autoreverses: true)){
                animateWrong = newValue
                
            }
        })
        .onTapGesture {
            square.isSelected.toggle()
        }
    }
}

struct DisplayBottom: View {
    
    @EnvironmentObject var vm: PuzzleViewModel
    @State var puzzleLiked = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Circle()
                        .fill(vm.colorToMove == "w" ?  .white : .black)
                        .overlay {
                            Circle()
                                .strokeBorder(Color.black, lineWidth: 1)
                        
                            
                        }
                                                
                    Text(vm.colorToMove == "w" ? "White to Move!" : "Black to Move!")
                        .foregroundColor(.black)
                    .font(.caption)
                    .scaledToFill()
                }
                .frame(height: 20)
                
                HStack {
                    Text("Difficulty:")
                        .foregroundColor(.black)
                    .font(.caption)
                    Text(String(vm.currentPuzzle?.rating ?? -1))
                        .foregroundColor(.black)
                    .font(.caption)

                }
                .frame(height: 20)


               
            }

            Divider()
            VStack(alignment: .leading) {
                Text("Themes:")
                    .foregroundColor(.black)
                    .font(.caption)
                Text(Converter.toSeparatedString(from: vm.currentPuzzle?.themes ?? "default"))
                    .foregroundColor(.black)
                    .font(.system(size: 10))
            }
  
            Divider()

            VStack(alignment: .leading) {
                Text("Opening Tags:")
                    .foregroundColor(.black)
                    .font(.caption)
                Text(Converter.openingTagToString(from: vm.currentPuzzle?.openingTags ?? "default"))
                    .foregroundColor(.black)
                    .font(.system(size: 10))
            }
            Divider()
            Image(systemName: puzzleLiked ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundColor(puzzleLiked ? .red : .black)
                .onTapGesture {
                    withAnimation {
                        puzzleLiked.toggle()
                    }
                }
                .alignmentGuide(.trailing) { vd in
                    vd[.trailing]
                }
        }
    }
}

struct DisplayTop: View {
    @EnvironmentObject var vm: PuzzleViewModel
    var body: some View {
        
        HStack {
            HStack {
                
                HStack {
                    AnimatedHudItem(imageName:"arrow.up.and.down", value: vm.puzzleRun?.usrRating ?? -1)
                }
                .font(.system(size: 20).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                AnimatedHudItem(imageName:"heart.fill", value: vm.tries)
                    .font(.system(size: 20).bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                
                AnimatedHudItem(imageName: "trophy.fill", value: vm.score)
                    .font(.system(size: 20).bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                AnimatedHudItem(imageName: "square.stack.3d.forward.dottedline.fill", value: vm.streak)
                    .font(.system(size: 20).bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                
            }
            .padding(10)
            .frame(height: 50)
            
        }
        .background(Color("ColorMainDark"))
        .cornerRadius(6)
        .background( Color("ColorMainDark").padding(.top, 6))
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PuzzleViewModel()
        
        ZStack {
            Color.red
            BoardView().environmentObject(viewModel)
        }
        
    }
    
}
