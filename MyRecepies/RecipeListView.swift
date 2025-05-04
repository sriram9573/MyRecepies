//  RecipeListView.swift
//  MyRecipeBox
//
//  Created by Sri Ram Reddy Lankireddy on 17/03/24.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @State private var showingNewRecipeView = false
    @State private var navigateToDishListView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            Text(recipe.title)
                        }
                    }
                    .onDelete(perform: deleteRecipe)
                }

                // ← Move the Map button here
                NavigationLink(destination: MapView()) {
                    Text("Find Nearest Grocery Stores")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)

                // (Optional) If you still need your hidden navigation into browsing:
                NavigationLink(destination: DishListView(), isActive: $navigateToDishListView) {
                    EmptyView()
                }
            }
            .navigationTitle("My Recipe Box")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        navigateToDishListView = true
                    } label: {
                        Label("Browse Recipes", systemImage: "globe")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewRecipeView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewRecipeView) {
                NewRecipeView(isPresented: $showingNewRecipeView) { newRecipe in
                    viewModel.addRecipe(newRecipe)
                }
            }
        }
    }

    private func deleteRecipe(at offsets: IndexSet) {
        viewModel.recipes.remove(atOffsets: offsets)
    }
}
