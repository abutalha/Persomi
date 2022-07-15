//
//  ResultScreen.swift
//  Persomi
//
//  Created by AbuTalha on 15/07/2022.
//

import SwiftUI

struct ResultScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var persoVM: PersoViewModel
    @State var score: String = "..."
    var details: String = "..."
    
    var body: some View {
        VStack (spacing: 30) {
            Image("LaunchScreen", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .foregroundColor(.accentColor).opacity(0.75)
            Text(persoVM.getPersonalityTitle()).bold()
                .font(.largeTitle)
            ScrollView {
                Text(persoVM.getPersonalityTrait())
                    .font(.title3)
            }
            Spacer()
            Button("Restart", role: .destructive) {
                persoVM.reset()
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
        }.padding(30)
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreen()
    }
}
