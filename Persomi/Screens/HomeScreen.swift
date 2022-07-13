//
//  HomeScreen.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI

let PROGRESSBAR_HEIGHT = 10.0

struct ProgressBar: View {
    var value: Float
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .leading) {
                Text ("2").font(.title3) +
                Text (" of 14").font(.subheadline).foregroundColor(.secondary)
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color.accentColor.opacity(0.15)).cornerRadius(PROGRESSBAR_HEIGHT/2)
                        .frame(maxWidth: geo.size.width, maxHeight: PROGRESSBAR_HEIGHT)
                    Rectangle().fill(Color.accentColor).cornerRadius(PROGRESSBAR_HEIGHT/2)
                        .frame(maxWidth: geo.size.width * CGFloat(value),
                               maxHeight: PROGRESSBAR_HEIGHT)
                }
            }.padding()
        }
    }
}

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Spacer()
                Text("You’re really busy at work and a colleague is telling you their life story and personal woes.")
                    .font(.title3)
                    .padding(.horizontal, 30)
                Spacer()
                Group {
                    ForEach (1..<5) { index in
                        Button  {
                            
                        } label: {
                            HStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.secondary)
                                Text("Option is big tested now with more options \(index)")
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 44, alignment: .leading)
                        }

                    }
                }.padding(.horizontal, 30)
                
                Button  {
                    print("Next")
                } label: {
                    Text("Next Question  →")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                }
                .padding(.top, 30)
                .ignoresSafeArea()
            }
        }
        .safeAreaInset(edge: .top) {
            ProgressBar(value: 0.2)
        }
//        .safeAreaInset(edge: .bottom) {
//            Button  {
//                print("Next")
//            } label: {
//                Text("Next Question  →")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, maxHeight: 60)
//                    .background(Color.accentColor)
//                    .foregroundColor(.white)
//            }
//            .background(Color.accentColor)
//        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
