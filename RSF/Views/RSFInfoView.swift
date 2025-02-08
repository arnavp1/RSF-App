//
//  RSFInfoView.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import SwiftUI

struct RSFInfoView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("RSF Information")
                    .font(.largeTitle)
                    .bold()

                Group {
                    Text("Hours of Operation:")
                        .font(.headline)
                    Text("Mon-Fri: 6 AM - 10 PM\nSat-Sun: 8 AM - 8 PM")

                    Text("⚽ Amenities:")
                        .font(.headline)
                    Text("• Weight Rooms\n• Basketball Courts\n• Swimming Pool\n• Group Fitness Classes")
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}
