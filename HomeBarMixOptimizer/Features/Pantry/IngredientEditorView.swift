
import SwiftUI

struct IngredientEditorView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var category: IngredientCategory
    @State private var notes: String
    @State private var isFavorite: Bool

    private let ingredientId: UUID?
    private let onSave: (Ingredient) -> Void

    init(ingredient: Ingredient?, onSave: @escaping (Ingredient) -> Void) {
        self.ingredientId = ingredient?.id
        _name = State(initialValue: ingredient?.name ?? "")
        _category = State(initialValue: ingredient?.category ?? .juices)
        _notes = State(initialValue: ingredient?.notes ?? "")
        _isFavorite = State(initialValue: ingredient?.isFavorite ?? false)
        self.onSave = onSave
    }

    var body: some View {
        Form {
            Section("Basics") {
                TextField("Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(IngredientCategory.allCases) { cat in
                        Text("\(cat.emoji) \(cat.title)").tag(cat)
                    }
                }
                Toggle("Favorite", isOn: $isFavorite)
            }

            Section("Notes") {
                TextField("Brand, sweetness, acidity…", text: $notes, axis: .vertical)
                    .lineLimit(3...6)
            }
        }
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle(ingredientId == nil ? "New ingredient" : "Edit ingredient")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }

                    let model = Ingredient(
                        id: ingredientId ?? UUID(),
                        name: trimmed,
                        category: category,
                        isFavorite: isFavorite,
                        notes: notes
                    )
                    onSave(model)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        IngredientEditorView(ingredient: nil) { _ in }
    }
}
