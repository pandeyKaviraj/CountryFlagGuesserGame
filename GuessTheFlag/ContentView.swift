//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kaviraj Pandey on 15/05/23.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreValue = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var countries = ["Estonia", "Germany", "Nigeria", "France", "US", "UK", "Ireland", "Spain","Poland", "Russia", "Italy", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreValue)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong"
            scoreValue -= 1
        }
        showingScore = true
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
