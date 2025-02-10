import SwiftUI

struct CrowdMeterView: View {
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue
    @State private var showSafari = false

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
                        .frame(height: 400)
                        .cornerRadius(10)
                        .padding()
                    
                    // Join Virtual Line Button
                    Button(action: {
                        showSafari = true
                    }) {
                        Text("Join Virtual Line")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedAccentColor.color)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
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
                        .frame(height: 400)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .padding()
            .sheet(isPresented: $showSafari) {
                SafariView(url: URL(string: "https://berkeley-rec-well.app.qless.com/kiosk/ee21e564-039f-488a-a68d-6d5039e62745")!)
            }
        }
    }
}
