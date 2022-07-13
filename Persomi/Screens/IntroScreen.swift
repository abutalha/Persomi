//
//  IntroScreen.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI

struct IntroScreen: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 30) {
            Text("Are you an introvert or extrovert?")
                .font(.largeTitle)
            Spacer(minLength: 10)
            Text("Let's find out,")
                .font(.headline)
            Text("You will be given a set of questions along with multiple choices, do you best to answer the questions honestly. In the end you can find out your personality, cool huh?")
                .font(.body)
            Text("All questions are mandatory")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer(minLength: 10)
            Button  {
                print("OK, Let's Go")
            } label: {
                Text("OK, Let's Go")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
        }.padding(40)
    }
}


struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen()
    }
}
