//
//  PuzzleSolvedCard.swift
//  Chezzle
//
//  Created by Jakob Peter on 07.07.23.
//

import SwiftUI

struct PuzzleSolvedCard: View {
    
    @Binding var show: Bool
    @State var animate = false
    @State var animateStroke = false
    
    var body: some View{
        VStack{
            if (animate){
                ZStack {
                    Circle()
                        .foregroundStyle(.white.gradient.shadow(.inner(color: Color("ColorDark"), radius: 4)))
                        .frame(width:200)
                        .shadow(radius: 3)
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
                            .foregroundColor(Color("ColorMainDark"))
                            .font(.system(size: 60))
                        Text("puzzle")
                            .font(.system(size: 30,weight: .bold))
                            .foregroundColor(Color("ColorMainDark"))
                        Text("solved")
                            .font(.system(size: 30,weight: .bold))
                            .foregroundColor(Color("ColorMainDark"))
                        Spacer()
                    }
                }
                .transition(.scale)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        show.toggle()
                    }
                }
            }
        }
        .onChange(of: show) { newValue in
            withAnimation(animate ? .easeIn(duration: 0.2):  .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)){
                animate = newValue
                print("triggered")
            }
            animateStroke.toggle()
        }
    }
}

struct PuzzleSolvedCard_Previews: PreviewProvider {
    static var previews: some View {
        var binding = PreviewBinding()
        VStack {
            PuzzleSolvedCard(show: binding.$bool)
            Button("toggle"){
                binding.bool = true
            }
        }
        
        
    }
}

class PreviewBinding: ObservableObject {
    @State var bool = false {
        didSet {
            print(bool)
        }
    }
}
