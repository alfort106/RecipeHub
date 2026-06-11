//
//  ContentView.swift
//  RecipeHub
//
//  Created by arakawa hinata on 2026/06/10.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes = Recipe.sampleData
    @State private var isShowingAddRecipe = false

    var body: some View {
        NavigationStack {
            List {
                ForEach($recipes) { $recipe in
                    NavigationLink {
                        RecipeDetailView(recipe: $recipe) {
                            RecipeStorage.save(recipes)
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipe.name)
                                .font(.headline)

                            Text(recipe.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text("\(recipe.cookingTimeMinutes)分")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("レシピ一覧")
            .onAppear {
                recipes = RecipeStorage.loadRecipes()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddRecipe) {
                AddRecipeView { recipe in
                    recipes.append(recipe)
                    RecipeStorage.save(recipes)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
