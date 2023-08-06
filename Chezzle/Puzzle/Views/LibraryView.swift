//
//  TrainingView.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//
import SwiftUI


struct LibraryView: View {
    
    @EnvironmentObject var vm: PuzzleViewModel
    
    @State var currentList = LibraryItem.search

    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("Library")
                    .font(.custom(AppFontName.title, size: 40))
                    .foregroundColor(.white)
                Spacer()
                ForEach(LibraryItem.allCases, id: \.self) { item in
                    item.img
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .foregroundColor(currentList == item ? AppColor.main : .white)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                currentList = item
                            }
                        }
                    
                }
                
            }
            .padding(8)
            .frame(height: 50)
            
            VStack {
                switch currentList {
                case .search:
                    SearchView()
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .opacity))
                case .history:
                    HistoryView()
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .opacity))
                case .favourites:
                    HistoryView()
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .opacity))                }
            }
            
            
        }
        
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.red.ignoresSafeArea()
            LibraryView().environmentObject(PuzzleViewModel())
        }
        
    }
}

struct SearchView: View {
    @State var rating = 50.0
    @EnvironmentObject var vm: PuzzleViewModel
    
    var body: some View {
        VStack {
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
        ScrollView {
            ForEach(0 ..< 10) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Board(squares: vm.squares)
                            .scaledToFill()
                            .border(.white, width: 2)
                            .padding(8)
                            .frame(width: 100, height: 100, alignment: .leading)
                        VStack(alignment: .leading) {
                            Text("Puzzle \(item)")
                                .font(.custom(AppFontName.title2, size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Text("some puzzle data: 12.08.27 \nName: errg \nDifficulslvl: 3456 ")
                                .font(.title3)
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.3)
                        }
                        .padding(8)
                        .frame(height: 100)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .shadow(radius: 3))
            }
        }
    }
}

struct HistoryView: View {
    
    @State var rating = 50.0
    @EnvironmentObject var vm: PuzzleViewModel
    
    var body: some View {
        ScrollView {
            ForEach(0 ..< 10) { item in
                VStack(alignment: .leading) {
                    HStack {
                        Board(squares: vm.squares)
                            .scaledToFill()
                            .border(.white, width: 2)
                            .padding(8)
                            .frame(width: 100, height: 100, alignment: .leading)
                        VStack(alignment: .leading) {
                            Text("Puzzle \(item)")
                                .font(.custom(AppFontName.title2, size: 20))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Text("some puzzle data: 12.08.27 \nName: errg \nDifficulslvl: 3456 ")
                                .font(.title3)
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.3)
                        }
                        .padding(8)
                        .frame(height: 100)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .shadow(radius: 3))
            }
        }
    }
}
