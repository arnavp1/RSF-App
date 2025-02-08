//
//  RSFInfoView.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import SwiftUI

struct RSFInfoView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: RSF Information Title
                    sectionContainer {
                        Text("RSF Information")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                .padding()
            }
            .background(Color(.systemGray6))
            .navigationTitle("RSF Information")
        }
    }
    
    // MARK: - Section Container Modifier
    @ViewBuilder
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}
