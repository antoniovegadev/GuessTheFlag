//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Antonio Vega on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var text = "- - - -"
    @State private var showAlert = false
    let secretCode = "1 0 0 9"

    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                Text(text)
                    .font(.title)
                    .padding()
                
                ForEach(0 ..< 3) { row in
                    HStack {
                        ForEach(0 ..< 3) { col in
                            let num = row * 3 + col + 1
                            Button(action: {
                                enterNumber(num)
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
                
                Button(action: {
                    enterNumber(0)
                }) {
                    Image(systemName: "0.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
            }
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("SUCCESS!"), message: Text("You entered the secret code!"), dismissButton: Alert.Button.default(Text("Ok"), action: {
                    text = "- - - -"
                }))
            }
        }
    }
    
    func enterNumber(_ number: Int) {
        if let nextDashLocation = text.firstIndex(of: "-") {
            text.remove(at: nextDashLocation)
            text.insert(contentsOf: "\(number)", at: nextDashLocation)
        }
        
        if text.last != "-" {
            checkCode()
            if !showAlert {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    text = "- - - -"
                }
            }
        }
    }
    
    func checkCode() {
        if text == secretCode {
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
