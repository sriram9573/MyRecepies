//
//  API.swift
//  MyRecepies
//
//  Created by Sri Ram Reddy Lankireddy on 16/04/24.
//

import SwiftUI

struct ApiResponse: Decodable {
    let count: Int?
    let results: [RecipeDetail]?
}

struct RecipeDetail: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let instructions: [Instruction]
    var sections: [Section]

    struct Instruction: Identifiable, Decodable {
        let displayText: String
        var id: String { displayText }

        enum CodingKeys: String, CodingKey {
            case displayText = "display_text"
        }
    }

    struct Section: Identifiable, Decodable {
        let components: [Component]
        let id = UUID()

        struct Component: Identifiable, Decodable {
            let rawText: String
            var id: String { rawText }

            enum CodingKeys: String, CodingKey {
                case rawText = "raw_text"
            }
        }
    }
}

class DishViewModel: ObservableObject {
    @Published var recipes: [RecipeDetail] = []
    @Published var isLoading = false

    func fetchRecipes(for query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&q=\(encodedQuery)") else {
            print("Invalid URL or query")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("7fa8cf19ddmsh3cfc6ede5afbf9ap1002a8jsn0a9c120e6e2e", forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("tasty.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        isLoading = true
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            if let error = error {
                print("Fetch failed: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data in response")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.recipes = decodedResponse.results ?? []
                }
            } catch {
                print("Decoding failed: \(error)")
            }
        }.resume()
    }
}

struct DishListView: View {
    @StateObject var viewModel = DishViewModel()
    @State private var searchText = ""

    var body: some View {
            VStack {
                TextField("Search recipes", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Search") {
                    viewModel.fetchRecipes(for: searchText)
                }
                .padding()

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: DishDetailView(recipe: recipe)) {
                            Text(recipe.name)
                        }
                    }
                }
            }
            .navigationTitle("Browse Recipes")
        }
    }

struct DishDetailView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    let recipe: RecipeDetail

    var body: some View {
        ScrollView {
            Text(recipe.name)
                .font(.title)
                .fontWeight(.bold)

            if let description = recipe.description {
                Text(description)
                    .padding(.bottom)
            }

            if !recipe.sections.isEmpty {
                Text("Ingredients")
                    .font(.headline)
                    .padding(.bottom, 5)
                ForEach(recipe.sections) { section in
                    ForEach(section.components) { component in
                        Text("• \(component.rawText)")
                            .padding(.bottom, 2)
                    }
                }
            }

            if !recipe.instructions.isEmpty {
                Text("Instructions")
                    .font(.headline)
                    .padding(.top, 10)
                ForEach(recipe.instructions) { instruction in
                    Text(instruction.displayText)
                        .padding(.bottom, 2)
                }
            }

            // ← Only here: Add to My Recipe Box
            Button("Add to My Recipe Box") {
                let ingredients = recipe.sections
                    .flatMap { $0.components.map(\.rawText) }
                let steps = recipe.instructions.map(\.displayText)
                let newRecipe = Recipe(
                    title: recipe.name,
                    ingredients: ingredients,
                    steps: steps
                )
                viewModel.addRecipe(newRecipe)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding([.leading, .trailing, .top])
        }
        .padding()
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
