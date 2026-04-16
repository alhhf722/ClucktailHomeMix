
import SwiftUI

struct PantryImportView: View {
    @EnvironmentObject private var store: AppDataStore
    @Environment(\.dismiss) private var dismiss

    @State private var text = ""
    @State private var replaceExisting = false

    var body: some View {
        Form {
            Section {
                Text("Each line or comma-separated phrase becomes one ingredient. Category is guessed from words (lime, tonic, syrup…).")
                    .font(.footnote)
                    .foregroundStyle(HBColor.secondary)
            }

            Section("Text") {
                TextEditor(text: $text)
                    .frame(minHeight: 160)
            }

            Section {
                Toggle("Update category if the name already exists", isOn: $replaceExisting)
            }

            Section {
                Button("Import") {
                    store.importPantryText(text, replaceDuplicatesByName: replaceExisting)
                    dismiss()
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Import to bar")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") { dismiss() }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PantryImportView()
            .environmentObject(AppDataStore())
    }
}
