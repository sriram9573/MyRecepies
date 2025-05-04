//  RecipeDetailView.swift
//  MyRecipeBox
//  Created by Sri Ram Reddy Lankireddy on 17/03/24.

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var showSteps = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing, .top])

                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding([.leading, .trailing, .top])

                VStack(alignment: .leading, spacing: 5) {
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                    }
                }

                Button {
                    withAnimation { showSteps.toggle() }
                } label: {
                    HStack {
                        Text(showSteps ? "Hide Steps" : "Show Steps")
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: showSteps ? "chevron.up" : "chevron.down")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding([.leading, .trailing, .top])
                }

                if showSteps {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(Array(recipe.steps.enumerated()), id: \.0) { index, step in
                            Text("\(index + 1). \(step)")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationTitle("Recipe Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
