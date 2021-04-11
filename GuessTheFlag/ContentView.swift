//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antonio Vega on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var showAlert = false


    
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                Text("Enter the secret code")
                    .font(.title)
                    .padding()
                
                ForEach(0 ..< 3) { row in
                    HStack {
                        ForEach(0 ..< 3) { col in
                            let num = row * 3 + col + 1
                            Button(action: {
                                text += String(num)
                                checkCode()
                            }) {
                                Image(systemName: "\(num).circle.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 50)
                            }
                        }
                    }
                }
            }
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("SUCCESS!"), message: Text("You entered the secret code!"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
    
    func checkCode() {
        if text.count == 4 {
            if text == "1119" {
                showAlert = true
            }
            text = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
