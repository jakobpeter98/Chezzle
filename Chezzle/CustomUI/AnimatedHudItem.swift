//
//  AnimatedHudItem.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct AnimatedHudItem: View {
    let imageName: String
    var value: Int
    
    @State var imageTransition = false
    @State var textTransition = false
    
    @Namespace private var transition
    
    var body: some View{
        HStack(alignment: .bottom, spacing: 2){
            
            if imageTransition {
                Image(systemName: imageName)
                    .foregroundColor(Color.white)
                    .aspectRatio(contentMode: .fit)
                    .transition(AnyTransition.asymmetric(insertion: .scale(scale: 1.2), removal: .scale(scale: 1.0)))
                    .matchedGeometryEffect(id: "image", in: transition)
                
                
            } else {
                Image(systemName: imageName)
                    .foregroundColor(Color.white)
                    .aspectRatio(contentMode: .fit)
                    .transition(AnyTransition.asymmetric(insertion: .scale(scale: 1.2), removal: .scale(scale: 1.0)))
                    .matchedGeometryEffect(id: "image", in: transition)
            }
            
            if textTransition {
                Text(String(value))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .top), removal: AnyTransition.scale))
                
            }else{
                Text(String(value))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .top), removal: AnyTransition.scale))
            }
            
        }
        .onChange(of: value) { newValue in
            withAnimation(.spring(response: 0.2,dampingFraction: 0.32, blendDuration: 0.2)) {
                textTransition.toggle()
                
            }
            withAnimation(.spring().delay(0.5)) {
                imageTransition.toggle()
            }
            
        }
        
    }
}

struct AnimatedHudItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AnimatedHudItem(imageName: "person.fill", value: 12)
            Text("LOL")
        }
        
    }
}
