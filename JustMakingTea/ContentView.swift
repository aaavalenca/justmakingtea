//
//  ContentView.swift
//  JustMakingTea
//
//  Created by aaav on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    
    let teaColor = Color(.blue)
    @State var opacity = 0.0
    @State var offset : CGSize = .zero
    @State var isDipping = false
    let winningTea = 0.6
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack{
            
            Image("color")
                .resizable().scaledToFit().clipShape(Circle()).frame(width: 60, height: 60).foregroundColor(teaColor.opacity(winningTea))
            
            ZStack{
                Image("teabag")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Image("teabagColor")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .foregroundColor(teaColor.opacity(0.5))
            }
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged {
                        value in withAnimation(.spring()){
                            offset = value.translation
                            if (value.translation.height > 116 && value.translation.height < 260 ){
                                isDipping = true
                            } else {
                                isDipping = false
                            }
                            
                        }
                    }
                    .onEnded {
                        value in withAnimation(.spring()){
                            offset = .zero
                            isDipping = false
                            if (opacity >= winningTea - 0.1 && opacity <= winningTea + 0.1){
                                print("GANHOU!")
                            } else if (opacity > winningTea + 0.1){
                                print("PASSOU")
                            } else {
                                print("TÁ FRACO AINDA")
                            }
                        }
                    }
            )
            ZStack{
                Image("teaColor")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .foregroundColor(teaColor.opacity(opacity))
                
                Image("teacup")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .onReceive(timer, perform: { value in
                if (isDipping && opacity < 1){
                    opacity = opacity + 0.0005
//                    print(opacity)
                } else {
                    
                }
            }
                       
            )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
