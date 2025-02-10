import SwiftUI

struct RSFDetailsView: View {
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue
    @State private var showFacilityOverview = false
    @State private var showWhoCanUse = false
    @State private var showLocation = false
    @State private var showCustomerService = false
    @State private var showEquipment = false
    @State private var showWeightRoom = false
    @State private var showSportsAreas = false
    @State private var showLockerRooms = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: Facility Overview
                sectionContainer {
                    DisclosureGroup("🏢 Facility Overview", isExpanded: $showFacilityOverview) {
                        Text("The Recreational Sports Facility (RSF) holds over 100,000 square feet of activity space, including an Olympic-sized pool, weight rooms, basketball courts, and more.")
                            .padding(.top, 5)
                    }
                }

                // MARK: Who Can Use It?
                sectionContainer {
                    DisclosureGroup("🆔 Who Can Use It?", isExpanded: $showWhoCanUse) {
                        Text("The RSF facilities are open to Recreation & Wellbeing members. Be prepared to present proof of membership or purchase at the front desk.")
                            .padding(.top, 5)
                    }
                }

                // MARK: Location
                sectionContainer {
                    DisclosureGroup("📍 Location", isExpanded: $showLocation) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("**Address:**")
                            Text("2301 Bancroft Way, Berkeley, CA 94720")
                            Text("Parking is available along Bancroft Way and in the public spots in the RSF garage.")
                        }
                        .padding(.top, 5)
                    }
                }

                // MARK: Customer Service & Passport
                sectionContainer {
                    DisclosureGroup("💼 Customer Service & Passport Facility", isExpanded: $showCustomerService) {
                        Text("The RSF Customer Service Center handles memberships, passport services, and program information. Located at the entrance of RSF.")
                            .padding(.top, 5)
                    }
                }

                // MARK: Cardio Equipment
                sectionContainer {
                    DisclosureGroup("🏋️ Equipment & Spaces", isExpanded: $showEquipment) {
                        Text("The RSF offers treadmills, stairmasters, elliptical trainers, rowing machines, and stationary bikes across multiple floors.")
                            .padding(.top, 5)
                    }
                }

                // MARK: Weight Room
                sectionContainer {
                    DisclosureGroup("🏋️‍♂️ Weight Room", isExpanded: $showWeightRoom) {
                        Text("The weight room has Cybex machines, free weights, squat racks, pull-up stations, and a virtual queue system during peak hours.")
                            .padding(.top, 5)
                    }
                }

                // MARK: Sports Areas
                sectionContainer {
                    DisclosureGroup("🏀 Sports & Recreation Areas", isExpanded: $showSportsAreas) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("- **Field House**: Open recreation for basketball, volleyball, badminton.")
                            Text("- **Combatives Room**: Hosts group fitness and martial arts.")
                            Text("- **Blue & Gold Gym**: Additional spaces for basketball/volleyball.")
                            Text("- **Racquet & Squash Courts**: Available for reservation up to 72 hours in advance.")
                        }
                        .padding(.top, 5)
                    }
                }

                // MARK: Locker Rooms
                sectionContainer {
                    DisclosureGroup("🔐 Locker Rooms", isExpanded: $showLockerRooms) {
                        Text("Lockers are available in the back of RSF. Bags are not allowed beyond the front desk.")
                            .padding(.top, 5)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("RSF Details")
    }

    // MARK: - Section Container Modifier
    @ViewBuilder
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
    }
}
