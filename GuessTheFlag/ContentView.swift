//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antonio Vega on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0

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
                        Image(countries[number])
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
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
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
        }
        
        showingAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
