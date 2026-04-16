
import SwiftUI

struct PantryView: View {
    @EnvironmentObject private var store: AppDataStore
    @State private var showingEditor = false
    @State private var editingIngredient: Ingredient?
    @State private var showingImport = false
    @State private var showingTemplates = false
    @State private var searchText = ""

    private var filteredBySearch: [Ingredient] {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty { return store.ingredients }
        return store.searchIngredients(query: q)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HBHeroHeader(
                    title: "My bar",
                    subtitle: "Everything you have at home as juicy capsules. Star favorites and head to the mixer.",
                    systemImage: "refrigerator.fill"
                )

                if store.ingredients.isEmpty {
                    emptyState
                } else if filteredBySearch.isEmpty {
                    HBPlaceholderBlock(
                        systemImage: "magnifyingglass",
                        title: "No matches",
                        message: "Try a different query or clear the search."
                    )
                } else {
                    ForEach(IngredientCategory.allCases) { category in
                        let items = filteredBySearch.filter { $0.category == category }.sorted {
                            if $0.isFavorite != $1.isFavorite { return $0.isFavorite && !$1.isFavorite }
                            return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
                        }

                        if !items.isEmpty {
                            section(category: category, items: items)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("My bar")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search your bar…")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink {
                    GlobalSearchView()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(store.hbAppTheme.accent)
                }
                .accessibilityLabel("Global search")
            }

            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        editingIngredient = nil
                        showingEditor = true
                    } label: {
                        Label("New ingredient", systemImage: "plus.circle")
                    }

                    Button {
                        showingImport = true
                    } label: {
                        Label("Import list", systemImage: "square.and.arrow.down.on.square")
                    }

                    Button {
                        showingTemplates = true
                    } label: {
                        Label("Bar templates", systemImage: "wand.and.stars")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(HBColor.success)
                }
                .accessibilityLabel("Actions")
            }
        }
        .sheet(isPresented: $showingEditor) {
            NavigationStack {
                IngredientEditorView(ingredient: editingIngredient) { ingredient in
                    store.upsert(ingredient)
                }
            }
        }
        .sheet(isPresented: $showingImport) {
            NavigationStack {
                PantryImportView()
            }
            .environmentObject(store)
        }
        .sheet(isPresented: $showingTemplates) {
            NavigationStack {
                PantryTemplatesPickView()
            }
            .environmentObject(store)
        }
    }

    private var emptyState: some View {
        HBGlassCard(gradient: HBGradient.citrusSplash) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Your bar is empty — easy to fix 🍹")
                    .font(.headline)
                    .foregroundStyle(HBColor.structure)

                Text("Import a text list, pick a template, or add items manually.")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(HBColor.secondary)

                HBPrimaryPillButton(title: "Add ingredient", systemImage: "plus") {
                    editingIngredient = nil
                    showingEditor = true
                }
            }
        }
    }

    private func section(category: IngredientCategory, items: [Ingredient]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Text(category.emoji)
                    .font(.title2)
                Text(category.title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(HBColor.structure)
                Spacer()
            }

            VStack(spacing: 10) {
                ForEach(items) { ingredient in
                    NavigationLink {
                        IngredientDetailView(ingredient: ingredient)
                    } label: {
                        HBIngredientCapsule(
                            name: ingredient.name,
                            accent: category.accent,
                            emoji: category.emoji,
                            isSelected: ingredient.isFavorite
                        )
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contextMenu {
                        Button {
                            store.toggleFavorite(ingredientId: ingredient.id)
                        } label: {
                            Label(
                                ingredient.isFavorite ? "Remove from favorites" : "Add to favorites",
                                systemImage: ingredient.isFavorite ? "star.slash" : "star.fill"
                            )
                        }

                        Button(role: .destructive) {
                            store.deleteIngredient(id: ingredient.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        PantryView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
