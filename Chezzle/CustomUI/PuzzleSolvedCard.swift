//
//  PuzzleSolvedCard.swift
//  Chezzle
//
//  Created by Jakob Peter on 07.07.23.
//

import SwiftUI

struct PuzzleSolvedCard: View {
    
    @EnvironmentObject var viewModel: PuzzleViewModel
    
    @Binding var show: Bool
    @State var animate = false
    @State var animateStroke = false
    @State var fgColor = Color("ColorMainDark")
    @State var shadowColor = Color("ColorLightGray").opacity(0.5)
    
    var body: some View{
        VStack{
            if animate {
                VStack {
                    ZStack {
                        Circle()
                            .foregroundStyle(Gradient(colors: [Color.white, shadowColor]).shadow(.inner(color:  Color("ColorDark"), radius: 4)))
                            .frame(width:200)
                            .shadow(color: .gray, radius: 5, x: 2, y: 4)
                        Circle()
                            .trim(from: 0, to: animateStroke ? 1.0: 0.0)
                            .stroke(lineWidth: 6)
                            .rotation(.degrees(270))
                            .foregroundColor(Color.green)
                            .frame(width:200)
                            .animation(.easeInOut(duration: 0.7).delay(0.1), value: animateStroke)
                        VStack {
                            Spacer()
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(fgColor)
                                .font(.system(size: 60))
                            Text("puzzle")
                                .font(.system(size: 30,weight: .bold))
                                .foregroundColor(fgColor)
                            Text("solved")
                                .font(.system(size: 30,weight: .bold))
                                .foregroundColor(fgColor)
                            Spacer()
                        }
                    }
                    
                    
                }
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .onAppear{
                    fgColor = Color("ColorMainDark")
                    shadowColor = Color("ColorLightGray")
                    withAnimation(.spring(response: 0.3,dampingFraction: 0.7, blendDuration: 0.2).delay(0.6)) {
                        fgColor = Color.green
                    }
                }
                .onTapGesture {
                    show.toggle()
                    viewModel.puzzleRun?.setNextPuzzle()
                }
            }
        }
        .onChange(of: show) { newValue in
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)){
                animate = newValue
            }
            animateStroke.toggle()
        }
    }
}

struct BindingViewExamplePreview : View {
    @State var bool = false
    private var value = false
    
    var body: some View {
        ZStack {
            PuzzleSolvedCard(show: $bool)
            if !bool {
                Button("button") {
                    bool.toggle()
                }
            }
            
        }
    }
    
    struct PuzzleSolvedCard_Previews: PreviewProvider {
        static var previews: some View {
            BindingViewExamplePreview()
            
        }
        
        
    }
}


