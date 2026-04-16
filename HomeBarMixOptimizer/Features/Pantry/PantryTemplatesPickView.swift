
import SwiftUI

struct PantryTemplatesPickView: View {
    @EnvironmentObject private var store: AppDataStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("Templates add common items if those names are not already in your bar.")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(HBColor.secondary)
                    .padding(.horizontal, 4)
                    .hbGlassCell()

                ForEach(PantryTemplate.allCases) { tpl in
                    Button {
                        store.applyPantryTemplate(tpl)
                        dismiss()
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(HBGradient.liquidBlend(from: HBColor.citrusGlow, to: HBColor.mintMist))
                                .frame(width: 48, height: 48)
                                .overlay {
                                    Image(systemName: "sparkles")
                                        .font(.title3.weight(.bold))
                                        .foregroundStyle(Color.white)
                                }

                            VStack(alignment: .leading, spacing: 6) {
                                Text(tpl.title)
                                    .font(.headline)
                                    .foregroundStyle(HBColor.structure)
                                    .multilineTextAlignment(.leading)
                                Text(tpl.items.map(\.0).joined(separator: ", "))
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(HBColor.secondary)
                                    .lineLimit(4)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer(minLength: 0)
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundStyle(HBColor.success)
                        }
                        .hbGlassCell()
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .scrollIndicators(.hidden)
        .background(HBColor.canvas.ignoresSafeArea())
        .navigationTitle("Bar templates")
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
        PantryTemplatesPickView()
            .environmentObject(AppDataStore())
            .environment(\.hbAppTheme, HBAppTheme(variant: .lime))
    }
}
