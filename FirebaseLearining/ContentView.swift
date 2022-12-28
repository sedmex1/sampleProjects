//
//  ContentView.swift
//  FirebaseLearining
//
//  Created by Dominik Kowalewski on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        model.getData()
    }
    
    @ObservedObject var model = ViewModel()
    
    @State var name = ""
    @State var notes = ""
    @State var addNew = false
    @State var tap = false
    
    var body: some View {
        
        VStack {
            
            //MARK: Title
            Text("Your Tasks")
                .font(.largeTitle)
                .bold()
                .padding()
                .onAppear {
                    model.getData()
                }
            
            //MARK: Task List
            List() {
                ForEach(model.list, id: \.self) { item in
                    HStack {
                        VStack (alignment: .leading, spacing: 10){
                            Text(item.name)
                                .font(.title3)
                                .bold()
                            
                            Text(item.notes)
                                .font(.subheadline)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                        Button(action: {
                            model.deleteData(todoToDelete: item)
                        }, label: {
                            Image(systemName: "trash")
                        })
                        .tint(.red)
                    })
                    .padding(.horizontal, 5)
                }
            }
            .listStyle(PlainListStyle())
            
            //MARK: New Item Card
            
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.purple, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: addNew ? UIScreen.main.bounds.width : 55, height: addNew ? 260 : 55)
                    .cornerRadius(addNew ? 30 : 50)
                    .shadow(radius: 15)
                    .animation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 0.3), value: addNew)
                
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .shadow(radius: 5)
                    .rotationEffect(Angle(degrees: addNew ? 135 : 0))
                    .offset(x: addNew ? 170 : 0, y: addNew ? -100 : 0)
                    .animation(.spring(response: 0.7, dampingFraction: 0.85, blendDuration: 0.8), value: addNew)
                    .onTapGesture {
                        addNew.toggle()
                    }
                
                VStack (alignment: .leading, spacing: 20){
                    ZStack {
                        if name.isEmpty {
                            Text("Name...")
                                .foregroundColor(.white)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                        }
                        
                        TextField("", text: $name)
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.horizontal, 15)
                            .padding(5)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 1)
                    }
                    
                    
                    
                    ZStack {
                        if notes.isEmpty {
                            Text("Notes...")
                                .foregroundColor(.white)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                        }
                        
                        TextField("", text: $notes)
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.horizontal, 15)
                            .padding(5)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 1)
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 80, height: 35)
                        .reverseMask {
                            Text("Add")
                                .font(.title2)
                                .bold()
                        }
                        .shadow(color: tap ? .purple.opacity(1) : .black.opacity(0.3) , radius: tap ? 2 : 15)
                        .scaleEffect(tap ? 1 : 1.2)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                        .onTapGesture {
                            tap = true
                            if name != "" {
                                model.addData(name: name, notes: notes)
                            }
                            name = ""
                            notes = ""
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
                                tap = false
                            }
                        }
                        .animation(.spring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.5), value: tap)
                    
                }
                .allowsHitTesting(addNew)
                .scaleEffect(!addNew ? 0 : 1)
                .padding(!addNew ? 0 : 20)
                .padding(.top, 20)
                .animation(.spring(response: 0.7, dampingFraction: 0.85, blendDuration: 0.8), value: addNew)
            }
            .padding(addNew ? 0 : -50)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: View Extension

extension View {
    @inlinable
    public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}
