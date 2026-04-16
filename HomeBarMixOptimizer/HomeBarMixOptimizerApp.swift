
import SwiftUI
import UIKit

@main
struct HomeBarMixOptimizerApp: App {
    @StateObject private var dataStore = AppDataStore()

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().showsHorizontalScrollIndicator = false
        UITextView.appearance().showsVerticalScrollIndicator = false
        UITextView.appearance().showsHorizontalScrollIndicator = false
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(dataStore)
                .environment(\.hbAppTheme, dataStore.hbAppTheme)
        }
    }
}
