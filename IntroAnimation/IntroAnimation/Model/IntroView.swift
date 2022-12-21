//
//  IntroView.swift
//  IntroAnimation
//
//  Created by Dominik Kowalewski on 07/11/2022.
//

import SwiftUI

struct IntroView: View {
    //MARK: Animation Properties
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    
    var body: some View {
        ZStack {
            if showHomeView {
                HomeView()
                    .transition(.move(edge: .trailing))
            } else {
                ZStack {
                    Color("BG")
                        .ignoresSafeArea()
                    IntroScreen()
                        
                    NavBar()
                    
                    WalkThroughScreens()
                    
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: showHomeView)
    }
    
    //MARK: WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens()->some View {
        GeometryReader {
            let size = $0.size
            let isLast = currentIndex == intros.count
            
            ZStack {
                //MARK: Walk Through Screens
                ForEach(intros.indices, id: \.self) { index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeScreen(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //MARK: Next Button
            .overlay(alignment: .bottom) {
                //MARK: Converting Next button Into SignUp Button
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Sign Up")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                
                .frame(width: isLast ? size.width / 1.5 :  55, height: isLast ? 50 : 55)
                    .foregroundColor(.white)
                    .background{
                        RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .continuous)
                            .fill(Color("button"))
                    }
                    .onTapGesture {
                        if currentIndex == intros.count{
                            showHomeView = true
                        } else {
                            currentIndex += 1
                        }
                    }
                    .offset(y: isLast ? -27 : -60)
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .overlay(alignment: .bottom, content: {
                //MARK: Bottom Sign In Button
                let isLast = currentIndex == intros.count
                
                HStack (spacing: 5){
                    Text("Already have an account?")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Button("Login") {
                        
                    }
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color("button"))
                }
                .offset(y: isLast ? 0 : 80)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.title)
                .fontWeight(.semibold)
            //MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            //MARK: Adding Delay to Elements based on Index
            //MARK: Adding Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index)).animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
        }
    }
    
    //MARK: Welcome Screen
    
    @ViewBuilder
    func WelcomeScreen(size: CGSize, index: Int) -> some View {
        VStack(spacing: 10) {
            
            Image("Image4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index)).animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Wlecome")
                .font(.title)
                .fontWeight(.semibold)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Stay organized and live stress-free with \n toy-do app")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
                
        }
        .offset(y: -20)
    }
    
    //MARK: Nav Bar
    @ViewBuilder
    func NavBar() -> some View {
        let isLast = currentIndex == intros.count
        HStack(alignment: .top) {
            Button {
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreens.toggle()
                }
                
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("button"))
                    
            }
            
            Spacer()
            
            Button("Skip") {
                currentIndex = intros.count
            }
            .font(.headline)
            .foregroundColor(Color("button"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    //MARK: Intro Screen
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Image2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height/2)
                
                Text("Clearhead")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(dummyText)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Text("Let's Begin")
                    .font(.title2)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background {
                    Capsule()
                        .fill(Color("button"))
                }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            //MARK: Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height: 0)
        }
        .ignoresSafeArea()
    }
    
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle("Home")
        }
    }
}
