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
    @State private var resetGame = false
    @State private var showingScore = false
    @State private var questionAsked = 0
    @State private var countries = ["Estonia", "Germany", "Nigeria", "France", "US", "UK", "Ireland", "Spain","Poland", "Russia", "Italy", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            RadialGradient(stops:
                            [
                                .init(color: Color(red: 0.1, green: 0.2, blue:0.45),location: 0.3),
                                .init(color: Color(red:0.76, green:0.15, blue:0.26), location: 0.3)
                            ],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
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
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score: \(scoreValue)")
                    .foregroundColor(.white)
                    .frame(minWidth: 20)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreValue)")
        }
        .alert(Text("Good work"), isPresented: $resetGame) {
            Button("Reset", action: reset)
        } message: {
            Text("Keep going friends")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct, that's the flag of \(countries[number])"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            scoreValue -= 1
        }
        questionAsked += 1
        showingScore = true
        if questionAsked == 8 {
            resetGame = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        scoreValue = 0
        questionAsked = 0
        showingScore = false
        resetGame = false
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
