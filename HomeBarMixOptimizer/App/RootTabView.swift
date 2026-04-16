
import SwiftUI
import UIKit

struct RootTabView: View {
    @EnvironmentObject private var dataStore: AppDataStore

    var body: some View {
        TabView(selection: $dataStore.selectedTab) {
            NavigationStack {
                PantryView()
            }
            .tabItem { Label("My bar", systemImage: "refrigerator.fill") }
            .tag(0)

            NavigationStack {
                MixerView()
            }
            .tabItem { Label("Mixer", systemImage: "sparkles") }
            .tag(1)

            NavigationStack {
                DiscoverView()
            }
            .tabItem { Label("Ideas", systemImage: "lightbulb.max.fill") }
            .tag(2)

            NavigationStack {
                RecipesView()
            }
            .tabItem { Label("Recipes", systemImage: "book.fill") }
            .tag(3)

            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
            .tag(4)
        }
        .environment(\.hbAppTheme, dataStore.hbAppTheme)
        .tint(dataStore.hbAppTheme.accent)
        .onAppear {
            configureTabBarAppearance(accent: dataStore.hbAppTheme.accent)
        }
        .onChange(of: dataStore.preferences.accentVariant) { _ in
            configureTabBarAppearance(accent: dataStore.hbAppTheme.accent)
        }
        .sheet(isPresented: $dataStore.showOnboarding) {
            OnboardingView()
                .environmentObject(dataStore)
                .environment(\.hbAppTheme, dataStore.hbAppTheme)
        }
    }

    private func configureTabBarAppearance(accent: Color) {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(HBColor.canvas)

        let item = UITabBarItemAppearance()
        item.normal.iconColor = UIColor(HBColor.secondary)
        item.normal.titleTextAttributes = [.foregroundColor: UIColor(HBColor.secondary)]
        item.selected.iconColor = UIColor(accent)
        item.selected.titleTextAttributes = [.foregroundColor: UIColor(HBColor.structure)]

        appearance.stackedLayoutAppearance = item
        appearance.inlineLayoutAppearance = item
        appearance.compactInlineLayoutAppearance = item

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    RootTabView()
        .environmentObject(AppDataStore())
}
