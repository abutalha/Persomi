//
//  HomeScreen.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var persoVM: PersoViewModel
    @State var currentIndex: Int = 0
//    @Binding var choiceIndex: Int
    
    var body: some View {
        NavigationView {
            if persoVM.allQuestions().count > 0 {
                VStack {
                    TabView (selection: $currentIndex) {
                        ForEach(persoVM.allQuestions().indices, id:\.self) { index in
                            QuestionView(question: persoVM.question(index))
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    HStack (spacing: 0) {
                        if (currentIndex > 0) {
                            Button  {
                                print("Previous")
                            } label: {
                                Text("Previous")
                                    .font(.headline)
                                    .frame(maxWidth: 120, maxHeight: 60)
                                    .background(Color.accentColor.opacity(0.2))
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                        Button  {
                            persoVM.saveUserResponse(currentIndex, 2)
                        } label: {
                            Text((currentIndex > 0) ? "Next Question  →" : "Submit")
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
            ProgressBar(currentQuestion: currentIndex, totalQuestions: persoVM.totalQuestions())
        }
    }
}

struct QuestionView : View {
    
    var question: Question
    @State var selectedAnswer:UUID?
    
    var body: some View {
        VStack (alignment: .leading)  {
            Spacer()
            Text(question.question)
                .font(.title3)
            Spacer()
            List(selection: $selectedAnswer) {
                ForEach (question.answers, id:\.self) { answer in
                    Label {
                        Text(answer)
                            .foregroundColor(Color(.label))
                            .multilineTextAlignment(.leading)
                    } icon: {
                        Image(systemName: "circle")
                            .foregroundColor(.secondary)
                    }
                    //.frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(.horizontal, 30)
        //                    Button  {
        //                    } label: {
        //                        HStack {
        //                            Image(systemName: "circle")
        //                                .foregroundColor(.secondary)
        //                            Text(answer)
        //                                .foregroundColor(Color(.label))
        //                                .multilineTextAlignment(.leading)
        //                        }
        //                        .frame(maxWidth: .infinity, maxHeight: 44, alignment: .leading)
        //                    }
        //                }
        //            }
        //        }.padding(.horizontal, 30)
    }
}

//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//HomeScreen()
//    }
//}
