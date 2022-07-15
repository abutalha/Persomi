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
                                persoVM.moveToNextQuestion()
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
        .fullScreenCover(isPresented: $persoVM.showResult) {
            ResultScreen()
                .environmentObject(persoVM)
        }
    }
}

