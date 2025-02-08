//
//  CrowdMeterView.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import SwiftUI

struct CrowdMeterView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // RSF Weight Room Crowd Meter
                VStack {
                    Text("RSF Weight Room Crowd Meter")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top)

                    WebView(url: URL(string: "https://safe.density.io/#/displays/dsp_956223069054042646?token=shr_o69HxjQ0BYrY2FPD9HxdirhJYcFDCeRolEd744Uj88e")!)
                        .frame(height: 400) // Adjust height as needed
                        .cornerRadius(10)
                        .padding()
                }

                Divider().padding(.horizontal)

                // CMS Fitness Capacity
                VStack {
                    Text("CMS Fitness Capacity")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top)

                    WebView(url: URL(string: "https://safe.density.io/#/displays/dsp_1160333760881754703?token=shr_CPp9qbE0jN351cCEQmtDr4R90r3SIjZASSY8GU5O3gR")!)
                        .frame(height: 400) // Adjust height as needed
                        .cornerRadius(10)
                        .padding()
                }
            }
            .padding()
        }
    }
}







/* old
 import SwiftUI

 struct CrowdMeterView: View {
     @StateObject private var viewModel = CrowdViewModel()
     
     var body: some View {
         NavigationView {
             List(viewModel.crowdData) { data in
                 VStack(alignment: .leading, spacing: 5) {
                     Text(data.location)
                         .font(.headline)
                     ProgressView(value: Double(data.occupancyPercentage), total: 100)
                         .progressViewStyle(LinearProgressViewStyle(tint: data.occupancyPercentage > 70 ? .red : .green))
                     Text("Occupancy: \(data.occupancyPercentage)%")
                         .font(.subheadline)
                     Text("Last Updated: \(formattedDate(data.lastUpdated))")
                         .font(.caption)
                         .foregroundColor(.gray)
                 }
                 .padding(.vertical, 8)
             }
             .navigationTitle("RSF Crowd Meter")
         }
     }
     
     private func formattedDate(_ date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .short
         return formatter.string(from: date)
     }
 }
*/
