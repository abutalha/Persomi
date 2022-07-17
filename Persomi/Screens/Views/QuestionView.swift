//
//  QuestionView.swift
//  Persomi
//
//  Created by AbuTalha on 15/07/2022.
//

import SwiftUI

struct QuestionView : View {
    @EnvironmentObject var persoVM: PersoViewModel
    var question: Question
    @State var selectedOption = -1
    
    var body: some View {
        VStack (alignment: .leading)  {
            Spacer()
            Text(question.question)
                .font(.title2)
                
            Spacer()
            VStack (spacing: 8) {
                ForEach (question.answers.indices, id:\.self) { index in
                    Button  {
                        print ("button index: \(index)")
                        withAnimation {
                            persoVM.saveUserResponse(index)
                            selectedOption = index
                        }
                    } label: {
                        HStack {
                            Image(systemName: selectedOption == index ?  "checkmark.circle.fill" : "circle")
                                .foregroundColor(selectedOption == index ? .purple : .secondary)
                            Text(question.answers[index])
                                .font(.subheadline)
                                .fontWeight(selectedOption == index ? .medium : .regular)
                                .padding(.vertical)
                                .foregroundColor(Color(.label))
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedOption == index ? Color.purple : Color.clear, lineWidth: 2)
                            )
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
}
