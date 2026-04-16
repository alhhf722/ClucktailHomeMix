
import SwiftUI

struct MixHistoryView: View {
    @EnvironmentObject private var store: AppDataStore

    var body: some View {
        Group {
            if store.mixSessions.isEmpty {
                ScrollView {
                    HBPlaceholderBlock(
                        systemImage: "clock.arrow.circlepath",
                        title: "No history yet",
                        message: "Save sessions from the mixer — bring back winning blends in one tap."
                    )
                    .hbGlassCell()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 40)
                }
                .scrollIndicators(.hidden)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(store.mixSessions) { session in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(session.title)
                                    .font(.headline)
                                    .foregroundStyle(HBColor.structure)

                                Text(session.createdAt.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(HBColor.secondary)

                                if !session.note.isEmpty {
                                    Text(session.note)
                                        .font(.subheadline.weight(.medium))
                                        .foregroundStyle(HBColor.secondary)
                                }

                                Text(resolvedLine(session))
                                    .font(.footnote.weight(.medium))
                                    .foregroundStyle(HBColor.structure.opacity(0.85))
                                    .lineLimit(4)
                                    .fixedSize(horizontal: false, vertical: true)

                                HStack(spacing: 10) {
                                    Button("Restore") {
                                        store.restoreMixSession(session)
                                    }
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background {
                                        Capsule()
                                            .fill(
                                                LinearGradient(
                                                    colors: [HBColor.success, HBColor.mintMist.opacity(0.85)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                    }
                                    .hbGlowShadow()

                                    Button("Delete") {
                                        store.deleteMixSession(id: session.id)
                                    }
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(HBColor.berryPop)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background {
                                        Capsule()
                                            .fill(Color.white)
                                            .overlay {
                                                Capsule()
                                                    .strokeBorder(HBColor.structure.opacity(0.16), lineWidth: 1)
                                            }
                                    }
                                }
                                .padding(.top, 4)
                            }
                            .hbGlassCell()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }
                .scrollIndicators(.hidden)
            }
        }
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Mix history")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !store.mixSessions.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Clear all", role: .destructive) {
                        store.clearMixSessions()
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }

    private func resolvedLine(_ session: MixSession) -> String {
        let names = session.ingredientIds.compactMap { id in store.ingredients.first { $0.id == id }?.name }
        if names.isEmpty { return "Some ingredients are no longer in your bar — only available items will restore." }
        return names.joined(separator: " · ")
    }
}

#Preview {
    NavigationStack {
        MixHistoryView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
