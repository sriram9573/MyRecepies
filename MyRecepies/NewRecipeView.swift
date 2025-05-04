//
//  NewRecepieView.swift
//  MyRecepieBox
//
//  Created by Sri Ram Reddy Lankireddy on 17/03/24.
//

import SwiftUI

struct NewRecipeView: View {
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var ingredients: String = ""
    @State private var steps: String = ""
    
    var saveAction: ((Recipe) -> Void)?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Recipe Title", text: $title)
                }
                
                Section(header: Text("Ingredients (separate by commas)")) {
                    TextField("Ingredients", text: $ingredients)
                }
                
                Section(header: Text("Steps (separate by new lines)")) {
                    TextEditor(text: $steps)
                }
            }
            .navigationBarTitle("New Recipe", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    let newIngredients = ingredients.components(separatedBy: ",")
                    let newSteps = steps.components(separatedBy: "\n")
                    let newRecipe = Recipe(title: title, ingredients: newIngredients, steps: newSteps)
                    saveAction?(newRecipe)
                    isPresented = false
                }
            )
        }
    }
}

