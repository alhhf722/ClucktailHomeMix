
import SwiftUI

struct ShoppingListView: View {
    @EnvironmentObject private var store: AppDataStore
    @State private var newTitle = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 10) {
                    TextField("Add item", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                    Button("Add") {
                        store.addShoppingItem(title: newTitle, source: "Manual")
                        newTitle = ""
                    }
                    .font(.subheadline.weight(.bold))
                    .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .hbGlassCell()

                if store.shoppingItems.isEmpty {
                    HBPlaceholderBlock(
                        systemImage: "cart",
                        title: "List is empty",
                        message: "Add missing items from a playlist or recipe — or type them in."
                    )
                    .hbGlassCell()
                } else {
                    Text("To buy")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(HBColor.structure)
                        .padding(.top, 4)

                    ForEach(store.shoppingItems) { item in
                        HStack(alignment: .center, spacing: 12) {
                            Button {
                                store.toggleShoppingItem(id: item.id)
                            } label: {
                                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                                    .foregroundStyle(item.isChecked ? HBColor.success : HBColor.secondary)
                            }
                            .buttonStyle(.plain)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundStyle(HBColor.structure)
                                    .strikethrough(item.isChecked, color: HBColor.secondary)
                                    .multilineTextAlignment(.leading)
                                if !item.source.isEmpty {
                                    Text(item.source)
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(HBColor.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                store.toggleShoppingItem(id: item.id)
                            }

                            Button {
                                store.deleteShoppingItem(id: item.id)
                            } label: {
                                Image(systemName: "trash.circle.fill")
                                    .font(.title2)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(HBColor.berryPop)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Delete")
                        }
                        .hbGlassCell()
                    }

                    Button {
                        store.removeCheckedShoppingItems()
                    } label: {
                        Text("Remove checked")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background {
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .fill(HBColor.berryPop.opacity(0.92))
                            }
                            .hbCardShadow()
                    }
                    .buttonStyle(.plain)
                    .disabled(!store.shoppingItems.contains(where: \.isChecked))
                    .opacity(store.shoppingItems.contains(where: \.isChecked) ? 1 : 0.4)
                    .padding(.top, 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Shopping list")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        ShoppingListView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
