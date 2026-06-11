import SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss

    private let recipe: Recipe?
    let onSave: (Recipe) -> Void

    @State private var name: String
    @State private var description: String
    @State private var cookingTimeMinutes: Int
    @State private var ingredientsText: String
    @State private var stepsText: String

    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var title: String {
        recipe == nil ? "レシピ追加" : "レシピ編集"
    }

    init(recipe: Recipe? = nil, onSave: @escaping (Recipe) -> Void) {
        self.recipe = recipe
        self.onSave = onSave
        _name = State(initialValue: recipe?.name ?? "")
        _description = State(initialValue: recipe?.description ?? "")
        _cookingTimeMinutes = State(initialValue: recipe?.cookingTimeMinutes ?? 20)
        _ingredientsText = State(initialValue: recipe?.ingredients.joined(separator: "\n") ?? "")
        _stepsText = State(initialValue: recipe?.steps.joined(separator: "\n") ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("基本情報") {
                    TextField("レシピ名", text: $name)
                    TextField("説明", text: $description, axis: .vertical)
                        .lineLimit(2...4)

                    Stepper(
                        "調理時間: \(cookingTimeMinutes)分",
                        value: $cookingTimeMinutes,
                        in: 1...300,
                        step: 5
                    )
                }

                Section("材料") {
                    TextEditor(text: $ingredientsText)
                        .frame(minHeight: 120)
                }

                Section("作り方") {
                    TextEditor(text: $stepsText)
                        .frame(minHeight: 160)
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        saveRecipe()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private func saveRecipe() {
        let recipe = Recipe(
            id: recipe?.id ?? UUID(),
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            cookingTimeMinutes: cookingTimeMinutes,
            ingredients: lines(from: ingredientsText),
            steps: lines(from: stepsText)
        )

        onSave(recipe)
        dismiss()
    }

    private func lines(from text: String) -> [String] {
        text
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

#Preview {
    AddRecipeView { _ in }
}
