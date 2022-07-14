//
//  ProgressBar.swift
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
            VStack (alignment: .leading, spacing: 5) {
                Text ("2").font(.title3) +
                Text (" of 14").font(.subheadline).foregroundColor(.secondary)
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color.accentColor.opacity(0.15)).cornerRadius(PROGRESSBAR_HEIGHT/2)
                        .frame(maxWidth: geo.size.width, maxHeight: PROGRESSBAR_HEIGHT)
                    Rectangle().fill(Color.accentColor).cornerRadius(PROGRESSBAR_HEIGHT/2)
                        .frame(maxWidth: geo.size.width * CGFloat(value),
                               maxHeight: PROGRESSBAR_HEIGHT)
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 30)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 20)
    }
}
