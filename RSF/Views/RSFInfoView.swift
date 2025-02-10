import SwiftUI
import MapKit

struct RSFInfoView: View {
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue
    @State private var showRSFHours = false
    @State private var showVirtualLineFAQ = false
    @State private var showFeedbackForm = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.8696354, longitude: -122.2652308),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: RSF Hours (Collapsible)
                    sectionContainer {
                        DisclosureGroup(isExpanded: $showRSFHours) {
                            VStack(alignment: .leading, spacing: 5) {
                                RSFHoursRow(day: "Sunday", hours: "8 a.m. - 11 p.m.")
                                RSFHoursRow(day: "Monday", hours: "7 a.m. - 11 p.m.")
                                RSFHoursRow(day: "Tuesday", hours: "7 a.m. - 11 p.m.")
                                RSFHoursRow(day: "Wednesday", hours: "7 a.m. - 11 p.m.")
                                RSFHoursRow(day: "Thursday", hours: "7 a.m. - 11 p.m.")
                                RSFHoursRow(day: "Friday", hours: "7 a.m. - 11 p.m.")
                                RSFHoursRow(day: "Saturday", hours: "8 a.m. - 6 p.m.")
                            }
                            .padding(.top, 5)
                        } label: {
                            Text("📅 RSF Hours")
                                .font(.headline)
                        }
                    }

                    // MARK: Virtual Weight Room Line FAQs (Collapsible)
                    sectionContainer {
                        DisclosureGroup(isExpanded: $showVirtualLineFAQ) {
                            VStack(alignment: .leading, spacing: 10) {
                                FAQRow(question: "When do I need to use the virtual line?",
                                       answer: "The virtual line is in place Monday - Friday from 5:00 PM - 7:00 PM. In the future, it will activate when the crowd meter reaches 95% capacity.")

                                FAQRow(question: "Why is the wait time inaccurate?",
                                       answer: "The system is algorithm-based and adjusts to customer use patterns. We recommend joining the virtual line only when you’re within 10 minutes of the RSF.")

                                FAQRow(question: "How long do I have once I am summoned? Is there a time limit?",
                                       answer: "You have a 10-minute window to arrive at the entrance after being summoned. There is no time limit once admitted.")

                                FAQRow(question: "Can my friend join me in the weight room?",
                                       answer: "Everyone must join the virtual line individually to be admitted.")

                                FAQRow(question: "What if I need to leave the weight room temporarily?",
                                       answer: "Let the staff at the entrance know before leaving, and they will allow you back in.")

                                FAQRow(question: "How do I sign up with an international phone number?",
                                       answer: "Use a computer kiosk or enter (510) 643-8038 as a placeholder. Check the screen at the weight room entrance for updates, as international numbers cannot receive text alerts.")

                                FAQRow(question: "How do I share feedback on the virtual line?",
                                       answer: "Please share your feedback using the official RSF feedback form.")

                                // Submit Feedback Button (Opens Google Form in SFSafariViewController)
                                Button(action: {
                                    showFeedbackForm = true
                                }) {
                                    Text("Submit Feedback")
                                        .font(.body)
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(selectedAccentColor.color)
                                        .cornerRadius(10)
                                        .padding(.top, 10)
                                }
                            }
                            .padding(.top, 5)
                        } label: {
                            Text("💡 Virtual Weight Room Line FAQs")
                                .font(.headline)
                        }
                    }
                    
                    // MARK: RSF Facility Information
                    sectionContainer {
                        NavigationLink(destination: RSFDetailsView()) {
                            Text("ℹ️ RSF Facility Information")
                                .font(.headline)
                                .foregroundColor(selectedAccentColor.color)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // MARK: RSF Policies
                    sectionContainer {
                        NavigationLink(destination: RSFPoliciesView()) {
                            Text("⚖️ RSF Policies")
                                .font(.headline)
                                .foregroundColor(selectedAccentColor.color)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // MARK: RSF Location & Interactive Map
                    sectionContainer {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("📍 RSF Location")
                                .font(.headline)

                            Text("2301 Bancroft Way\nBerkeley, CA 94720")
                                .font(.body)
                                .foregroundColor(.secondary)

                            Map(position: .constant(.region(region)), interactionModes: [.zoom, .pan])
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            
                            Button(action: openInAppleMaps) {
                                HStack {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.white)
                                    Text("Get Directions")
                                        .font(.body)
                                        .bold()
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedAccentColor.color)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("RSF Information")
            .sheet(isPresented: $showFeedbackForm) {
                SafariView(url: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSc5lBJYmwHbwxJ5nR-tzC1TR-8sJmh1EWO1KmD-qV8qP9eZuA/viewform")!)
            }
        }
    }
    
    // MARK: - Section Container Modifier
    @ViewBuilder
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(uiColor: .secondarySystemBackground)))
        .cornerRadius(10)
    }
}

// MARK: - RSF Hours Row View
struct RSFHoursRow: View {
    var day: String
    var hours: String

    var body: some View {
        HStack {
            Text(day)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            Text(hours)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

// MARK: - FAQ Row View
struct FAQRow: View {
    var question: String
    var answer: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(question)
                .font(.headline)
                .foregroundColor(.primary)
            Text(answer)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
    }
}

// Function to Open Apple Maps with Directions
func openInAppleMaps() {
    let coordinate = CLLocationCoordinate2D(latitude: 37.8696354, longitude: -122.2652308)
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
    mapItem.name = "Recreational Sports Facility (RSF)"
    mapItem.openInMaps()
}
