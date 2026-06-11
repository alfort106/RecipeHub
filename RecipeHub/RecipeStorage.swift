import Foundation

enum RecipeStorage {
    private static let recipesKey = "recipes"

    static func loadRecipes() -> [Recipe] {
        guard let data = UserDefaults.standard.data(forKey: recipesKey) else {
            return Recipe.sampleData
        }

        do {
            return try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            return Recipe.sampleData
        }
    }

    static func save(_ recipes: [Recipe]) {
        guard let data = try? JSONEncoder().encode(recipes) else {
            return
        }

        UserDefaults.standard.set(data, forKey: recipesKey)
    }
}
