//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antonio Vega on 4/10/21.
//

import SwiftUI

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var rotationAmount = 0.0
    @State private var fadeAmount = 1.0
    @State private var incorrect = false



    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        FlagImage(country: countries[number])
                            .overlay(incorrect ? Capsule().fill(Color.red.opacity(0.5)) : nil)
                            .opacity(number != correctAnswer ? fadeAmount : 1)
                            .rotation3DEffect(
                                .degrees(number == correctAnswer ? rotationAmount : 0.0),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
            
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Next Question"), action: {
                    askQuestion()
                }))
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreMessage = "You recieved +1 points"
            score += 1
            withAnimation {
                rotationAmount += 360
                fadeAmount = 0.25
            }
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
            withAnimation {
                incorrect = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            showingAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        fadeAmount = 1.0
        incorrect = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
