
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var store: AppDataStore

    var body: some View {
        Form {
            Section("Tools") {
                NavigationLink {
                    GlobalSearchView()
                } label: {
                    Label("Global search", systemImage: "magnifyingglass")
                }

                NavigationLink {
                    ShoppingListView()
                } label: {
                    Label("Shopping list", systemImage: "cart")
                }

                NavigationLink {
                    MixHistoryView()
                } label: {
                    Label("Mix history", systemImage: "clock.arrow.circlepath")
                }
            }

            Section("Taste preferences") {
                Toggle("Less sugar", isOn: binding(\.prefersLessSugar))
                Toggle("Dislike bitterness", isOn: binding(\.dislikesBitter))
                Toggle("Prefer sparkling by default", isOn: binding(\.defaultSparkling))
            }
            
            Section("Onboarding") {
                Button("Show onboarding again") {
                    store.resetOnboarding()
                }
            }
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func binding(_ keyPath: WritableKeyPath<UserPreferences, Bool>) -> Binding<Bool> {
        Binding(
            get: { store.preferences[keyPath: keyPath] },
            set: { newValue in
                var prefs = store.preferences
                prefs[keyPath: keyPath] = newValue
                store.updatePreferences(prefs)
            }
        )
    }

    private func binding(_ keyPath: WritableKeyPath<UserPreferences, AccentVariant>) -> Binding<AccentVariant> {
        Binding(
            get: { store.preferences[keyPath: keyPath] },
            set: { newValue in
                var prefs = store.preferences
                prefs[keyPath: keyPath] = newValue
                store.updatePreferences(prefs)
            }
        )
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
