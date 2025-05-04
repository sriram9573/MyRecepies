//
//  Recepie.swift
//  MyRecepieBox
//
//  Created by Sri Ram Reddy Lankireddy on 17/03/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit

public struct Recipe: Identifiable, Codable, Hashable {
    public var id = UUID()
    public var title: String
    public var ingredients: [String]
    public var steps: [String]
    
    public init(id: UUID = UUID(), title: String, ingredients: [String], steps: [String]) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.steps = steps
    }
}
struct GroceryStore: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


