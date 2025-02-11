import SwiftUI

struct RSFPoliciesView: View {
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue
    @State private var showGeneralPolicies = false
    @State private var showPersonalItems = false
    @State private var showEquipmentRules = false
    @State private var showGymEtiquette = false
    @State private var showCourtPolicies = false
    @State private var showWeightRoomRules = false
    @State private var showLockerRoomPolicies = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: General RSF Policies
                sectionContainer {
                    DisclosureGroup("📜 General RSF Policies", isExpanded: $showGeneralPolicies) {
                        Text("""
                        The RSF is committed to providing a safe and friendly environment for all members. Failure to comply with policies may result in loss of membership or legal action.
                        
                        Beginning January 2024, RSF lobby access is limited to UC Berkeley students, RecWell members, Cal Athletics staff, and uniformed AC Transit drivers when the Customer Service Center is closed.
                        """)
                        .padding(.top, 5)
                    }
                }

                // MARK: Bags & Personal Items
                sectionContainer {
                    DisclosureGroup("🎒 Bags & Personal Items", isExpanded: $showPersonalItems) {
                        Text("""
                        - All backpacks, bags, and personal items must be placed in a locker.
                        - Items are **not allowed** in activity areas or blocking door entrances/exits.
                        """)
                        .padding(.top, 5)
                    }
                }

                // MARK: Equipment Rules
                sectionContainer {
                    DisclosureGroup("🏋️ Equipment Rules", isExpanded: $showEquipmentRules) {
                        Text("""
                        - A **30-minute time limit** applies to all cardio equipment.
                        - Beverages must be in a resealable container.
                        - Proper attire, including closed-toe shoes, is required.
                        """)
                        .padding(.top, 5)
                    }
                }

                // MARK: Gym Etiquette
                sectionContainer {
                    DisclosureGroup("🏀 Gym & Field House Etiquette", isExpanded: $showGymEtiquette) {
                        Text("""
                        - **Shoes**: Only non-marking athletic shoes are allowed. No sandals or bare feet.
                        - **Prohibited Behavior**: No ball throwing against walls, hanging from rims, or dunking.
                        - **Cleanliness**: Keep areas free of clutter and store personal belongings in lockers.
                        - **Fighting**: Aggressive behavior will result in immediate removal.
                        """)
                        .padding(.top, 5)
                    }
                }

                // MARK: Court Policies
                sectionContainer {
                    DisclosureGroup("🏸 Court Policies (Racquetball, Squash, etc.)", isExpanded: $showCourtPolicies) {
                        Text("""
                        - **Safety**: Eyeguards are recommended.
                        - **Reservations**: Courts can be reserved up to one day in advance.
                        - **Marking Balls**: Only non-marking balls are permitted.
                        """)
                        .padding(.top, 5)
                    }
                }

                // MARK: Weight Room Rules
                sectionContainer {
                    DisclosureGroup("🏋️‍♂️ Weight Room Rules", isExpanded: $showWeightRoomRules) {
                        Text("""
                        - **Assistance**: Ask Fit Staff for help or a spot.
                        - **Time Limits**: 30-minute limit on cardio equipment when others are waiting.
                        - **Safety**: Olympic lifts and uncontrolled movements are prohibited.
                        - **Etiquette**: Allow others to “work-in” on equipment.
                        - **Personal Items**: Bags and gym equipment must be stored in lockers.
                        """)
                        .padding(.top, 5)
                    }
                }

                // MARK: Locker Room Policies
                sectionContainer {
                    DisclosureGroup("🔐 Locker Room Policies", isExpanded: $showLockerRoomPolicies) {
                        Text("""
                        - Only eligible RSF members can use the locker rooms.
                        - Long-term locker assignments are available for registered students and members.
                        - No personal training except by authorized Recreation & Wellbeing staff.
                        """)
                        .padding(.top, 5)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("RSF Policies")
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
