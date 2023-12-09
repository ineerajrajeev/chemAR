//
//  quizQuestions.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//
import SwiftUI

struct QuizQuestions: View {
    @State private var showMessage = false
    @State private var ans = false
    let info = getRandomElement(from: elements) ?? mockData
    @State private var question = questionGenerator()
    @State private var correctAnswer = ""
    @State private var options = [String]()
    
    let successMessages: [String] = ["Excellent", "Good job", "Great", "You seem to be a champion", "Keep it up", "Good", "Keep moving"]
    let failureMessages: [String] = ["Oops!", "Try again", "Not quite", "Incorrect", "Keep practicing", "Missed it", "Wrong answer"]

    init() {
        let initialQuestion = questionGenerator()
        self._correctAnswer = State(initialValue: initialQuestion.correctAnswer)
        self._options = State(initialValue: initialQuestion.options)
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Quiz")
                    .font(.title)
                    .fontWeight(.bold)
                if UIDevice.isiPad {
                    if showMessage {
                        Text(ans ? "\(successMessages.randomElement()!)": "\(failureMessages.randomElement()!)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(ans ? Color.green : Color.red)
                            .padding()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        showMessage = false
                                    }
                                }
                            }
                    }
                }
                Text("\(question.question)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            if (option == correctAnswer) {
                                ans = true
                                showMessage = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showMessage = false // Hides message after 1 second even for the correct answer
                                }
                                updateQuestion()
                            } else {
                                ans = false
                                showMessage = true
                            }
                        }) {
                            Text(option)
                                .padding()
                                .foregroundColor(Color.black)
                                .frame(width: 80, height: 50)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .clipShape(Capsule())
                        }
                        .padding(.vertical, 4)
                    }
                }
                if !UIDevice.isiPad {
                    if showMessage {
                        Text(ans ? "\(successMessages.randomElement()!)": "\(failureMessages.randomElement()!)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(ans ? Color.green : Color.red)
                            .padding()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        showMessage = false
                                    }
                                }
                            }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            correctAnswer = question.correctAnswer
            options = question.options
        }
    }
    
    func updateQuestion() {
        question = questionGenerator()
        correctAnswer = question.correctAnswer
        options = question.options
    }
}

#Preview {
    QuizQuestions()
}

