//
//  RecepieViewModel.swift
//  MyRecepieBox
//
//  Created by Sri Ram Reddy Lankireddy on 17/03/24.
//

import Foundation
import SwiftUI
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [] {
        didSet {
            saveRecipes()
        }
    }
    
    init() {
        loadRecipes()
    }

    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
    }

    func deleteRecipe(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
    }

    private func saveRecipes() {
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: "recipes")
        }
    }

    private func loadRecipes() {
        if let recipesData = UserDefaults.standard.data(forKey: "recipes"),
           let decodedRecipes = try? JSONDecoder().decode([Recipe].self, from: recipesData) {
            recipes = decodedRecipes
        }
    }
}


