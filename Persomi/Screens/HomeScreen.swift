//
//  HomeScreen.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var persoVM: PersoViewModel
    @AppStorage("showIntro") var showIntro: Bool = true
    
    init(quizDataService: QuizDataProtocol) {
        _persoVM = StateObject(wrappedValue: PersoViewModel(dataService: quizDataService))
    }
    
    var body: some View {
        NavigationView {
            if persoVM.allQuestions().count > 0 {
                VStack {
                    TabView (selection: $persoVM.currentIndex) {
                        ForEach(persoVM.allQuestions().indices, id:\.self) { index in
                            QuestionView(question: persoVM.question(index))
                                .environmentObject(persoVM)
                                .tag(index)
                                .id(persoVM.viewId)
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
                                Text(" ⇠ ")
                                    .font(.largeTitle)
                                    .frame(maxWidth: 100, maxHeight: 60)
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
        .fullScreenCover(isPresented: $showIntro) {
            IntroScreen()
        }
    }
}

