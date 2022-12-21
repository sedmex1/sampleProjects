//
//  Home.swift
//  Metaball
//
//  Created by Dominik Kowalewski on 27/10/2022.
//

import SwiftUI

struct Home: View {
    
    //Animation var
    @State var dragOffset: CGSize = .zero
    @State var startAnimation = false
    
    @State var type = "Single"
    var body: some View {
    
        VStack {
            Text("Metaball Animations")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
            Picker(selection: $type) {
                Text("Metaball")
                    .tag("Single")
                Text("Clubbed")
                    .tag("Clubbed")
            } label: {
                
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if type == "Single" {
                SingleMetaBall()
            } else {
                ClubbedView()
            }
            
        }
    }
    @ViewBuilder
    func ClubbedView()-> some View {
        //Timing is option to change animation time
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"),Color("Gradient2")], startPoint: .top, endPoint: .bottom))
            .mask {
                TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
                    Canvas { context, size in
                        
                    //Change color
                    context.addFilter(.alphaThreshold(min: 0.5, color: Color("Gradient1")))
                    //This blur is responsible for elasticity
                    context.addFilter(.blur(radius: 40))
                    //Drawing layer
                    context.drawLayer { ctx in
                        for index in 1...15 {
                            if let resolvedView = context.resolveSymbol(id: index) {
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                        //Count how many
                    ForEach(1...15,id: \.self) { index in
                        //Generating custom offset for each
                        let offset = (startAnimation ? CGSize(width: .random(in: -100...100), height: .random(in: -240...240)) : .zero)
                        ClubbedRoundedRectangle(offset: offset)
                            .tag(index)
                        }
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                startAnimation.toggle()
            }
        }
    
    @ViewBuilder
    func ClubbedRoundedRectangle(offset: CGSize) -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
        //Adding animation
            .animation(.easeInOut(duration: 5.0), value: offset)
    }
    
    
    // MARK: Single MetaBall Animation
    @ViewBuilder
    func SingleMetaBall() -> some View {
            //Gradient color with mask
            Rectangle()
                .fill(.linearGradient(colors: [Color("Gradient1"), Color("Gradient2")], startPoint: UnitPoint.top, endPoint: .bottom))
                .mask {
                    Canvas { context, size in
                        
                    //Change color
                    context.addFilter(.alphaThreshold(min: 0.5, color: Color("Gradient2")))
                    //This blur is responsible for elasticity
                    context.addFilter(.blur(radius: 40))
                    //Drawing layer
                    context.drawLayer { ctx in
                        for index in [1,2] {
                            if let resolvedView = context.resolveSymbol(id: index) {
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    Ball(offset: dragOffset)
                        .tag(1)
                    Ball()
                        .tag(2)
                }

                }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    dragOffset = value.translation
                })
                .onEnded({_ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.7)) {
                        dragOffset = .zero
                    }
                })
        )
    }
        
        @ViewBuilder
    func Ball(offset: CGSize = .zero ) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
