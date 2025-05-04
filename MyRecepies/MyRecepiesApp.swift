//
//  MyRecepiesApp.swift
//  MyRecepies
//
//  Created by Sri Ram Reddy Lankireddy on 17/03/24.
//

import SwiftUI

@main
struct MyRecepiesApp: App {
    @StateObject private var viewModel = RecipeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

