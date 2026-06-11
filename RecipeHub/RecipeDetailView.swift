import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    let onSave: () -> Void

    @State private var isShowingEditRecipe = false

    var body: some View {
        List {
            Section("説明") {
                Text(recipe.description)
            }

            Section("調理時間") {
                Text("\(recipe.cookingTimeMinutes)分")
            }

            Section("材料") {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
            }

            Section("作り方") {
                ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 24, height: 24)
                            .background(.tint, in: Circle())

                        Text(step)
                    }
                    .padding(.vertical, 2)
                }
            }
        }
        .navigationTitle(recipe.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("編集") {
                    isShowingEditRecipe = true
                }
            }
        }
        .sheet(isPresented: $isShowingEditRecipe) {
            AddRecipeView(recipe: recipe) { updatedRecipe in
                recipe = updatedRecipe
                onSave()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            recipe: .constant(Recipe(
                name: "オムライス",
                description: "ふんわり卵で包む定番の洋食です。",
                cookingTimeMinutes: 20,
                ingredients: [
                    "ごはん",
                    "卵",
                    "鶏肉",
                    "玉ねぎ",
                    "ケチャップ"
                ],
                steps: [
                    "鶏肉と玉ねぎを炒める",
                    "ごはんとケチャップを加えて炒める",
                    "卵を焼いてごはんを包む"
                ]
            )),
            onSave: {}
        )
    }
}
