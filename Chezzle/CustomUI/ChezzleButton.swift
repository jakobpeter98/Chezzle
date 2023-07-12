//
//  ChezzleButton.swift
//  Chezzle
//
//  Created by Jakob Peter on 06.07.23.
//

import SwiftUI

struct ChezzleButton: View {
    @State var bgColor = Color("ColorMainDark")
    @State var fgColor = Color.white
    @State var text: String? = nil
    @State var imgName: String? = nil
    @State var actionColor = Color("ColorMainLight")
    @State var isAction = false
    @State var autoRevert = true
    var action: () -> Void
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(bgColor)
                    .overlay {
                        HStack(spacing: 10){
                            if let imgName = imgName {
                                Image(systemName: imgName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle((isAction ? actionColor: fgColor).shadow(.inner(radius: isAction ? 0 : min(geo.size.width, geo.size.height)/50))
                                    )
                            }
                            
                            if let text = text {
                                Text(text)
                                    .font(.system(size: min(geo.size.width, geo.size.height) * 0.7).bold())
                                    .minimumScaleFactor(0.1)
                                
                                    .foregroundStyle((isAction ? actionColor: fgColor).shadow(.inner(radius: isAction ? 0 : min(geo.size.width, geo.size.height)/50))
                                    )
                                
                            }
                            
                        }
                        .padding(10)
                        
                    }
                    .shadow(radius: isAction ? 0 : 2)
            }
            .offset(CGSize(width: 0, height: isAction ? 1 : 0))
            .shadow(color:.black, radius: 2, x: isAction ? 1 : 2, y: isAction ? 3 : 4)
            .animation(.easeOut(duration: 0.2), value: isAction)
            .onTapGesture {
                if !isAction {
                    action()
                    isAction.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        if autoRevert {
                            isAction.toggle()
                        }
                    }
                }
                
                
            }
        }
    }
    
}

struct ChezzleButton_Previews: PreviewProvider {
    static var previews: some View {
        ChezzleButton(text: "ChezzleButton", imgName: "star.fill", autoRevert: false){
            print("ChezzleButton clicked")
        }.frame(width: 200,height: 50)
    }
}
