//
//  HomeScreen.swift
//  Persomi
//
//  Created by AbuTalha on 13/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var persoVM = PersoViewModel()
    @State var currentIndex: Int = 0
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Spacer()
                Text(persoVM.question(currentIndex))
                    .font(.title3)
                    .padding(.horizontal, 30)
                Spacer()
                Group {
                    ForEach (persoVM.answers(currentIndex), id:\.self) { answer in
                        Button  {
                        } label: {
                            HStack {
                                Image(systemName: "circle")
                                    .foregroundColor(.secondary)
                                Text(answer)
                                    .foregroundColor(Color(.label))
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
