//
//  HomeScreen.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var persoVM: PersoViewModel
    var body: some View {
        NavigationView {
            if persoVM.allQuestions().count > 0 {
                VStack {
                    TabView (selection: $persoVM.currentIndex) {
                        ForEach(persoVM.allQuestions().indices, id:\.self) { index in
                            QuestionView(question: persoVM.question(index))
                                .environmentObject(persoVM)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    HStack (spacing: 0) {
                        if (!persoVM.isFirstQuestion()) {
                            Button  {
                                withAnimation {
                                    persoVM.moveToPreviousQuestion()
                                }
                            } label: {
                                Text("Previous")
                                    .font(.headline)
                                    .frame(maxWidth: 120, maxHeight: 60)
                                    .background(Color.accentColor.opacity(0.2))
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                        Button  {
                            withAnimation {
                                persoVM.saveUserResponse(2)
                            }
                        } label: {
                            Text(persoVM.isLastQuestion() ? "Submit" : "Next Question  →")
                                .font(.headline)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 30)
                    .ignoresSafeArea()
                }
            } else {
                ProgressView("Loading...")
            }
        }
        .safeAreaInset(edge: .top) {
            if persoVM.allQuestions().count > 0 {
                ProgressBar(currentQuestion: $persoVM.currentIndex, totalQuestions: persoVM.totalQuestions())
            }
        }
    }
}

struct QuestionView : View {
    @EnvironmentObject var persoVM: PersoViewModel
    var question: Question
    @State var selectedAnswer:UUID?
    
    var body: some View {
        VStack (alignment: .leading)  {
            Spacer()
            Text(question.question)
                .font(.title3)
            Spacer()
            VStack (spacing: 8) { //(selection: $selectedAnswer) {
                ForEach (question.answers.indices, id:\.self) { index in
                    Button  {
                        print ("button index: \(index)")
                    } label: {
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(.secondary)
                            Text(question.answers[index])
                                .font(.subheadline)
                                .padding(.vertical)
                                .foregroundColor(Color(.label))
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
}
