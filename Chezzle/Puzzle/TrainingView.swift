//
//  TrainingView.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct TrainingView: View {
    
    @EnvironmentObject var vm: PuzzleViewModel
    @State var rating = 50.0
    var body: some View {
        VStack {
            VStack {
                Text("Training")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                ScrollView(.horizontal) {
                    HStack{
                        TagButton() {
                            
                        }
                        TagButton() {
                            
                        }
                        TagButton() {
                            
                        }
                        TagButton() {
                            
                        }
                    }
                    .padding(8)
                    
                    
                    
                }
                .scrollIndicators(.hidden)
                .frame(height: 50)
                HStack {
                    Slider(value: $rating) {
                        Text("Rating")
                            .foregroundColor(.black)
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("2000")
                    }
                    
                }
                .padding(.horizontal, 8)
            }
            .padding(.horizontal, 16)
            
            
            List(0 ..< 5) { item in
                VStack(alignment: .leading) {
                    
                    Text("Puzzle \(item)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(8)
                    Board(squares: vm.squares)
                        .scaledToFill()
                        .border(.white, width: 2)
                        .padding(8)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .shadow(radius: 3))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            Spacer()
        }
        
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.red.ignoresSafeArea()
            TrainingView().environmentObject(PuzzleViewModel())
        }
        
    }
}
