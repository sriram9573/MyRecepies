//
//  MapView.swift
//  MyRecepies
//
//  Created by Sri Ram Reddy Lankireddy on 15/04/24.
//
import SwiftUI
import MapKit

class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    @Published var groceryStores: [GroceryStore] = []
    @Published var shouldFollowUserLocation = true
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            if shouldFollowUserLocation {
                let center = location.coordinate
                region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                performGroceryStoresSearch(center: center)
            }
        }
    
    func performGroceryStoresSearch(center: CLLocationCoordinate2D) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "grocery store"
        searchRequest.region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let self = self, let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                self.groceryStores = response.mapItems.map { item in
                    GroceryStore(name: item.name ?? "Grocery Store", coordinate: item.placemark.coordinate)
                }

                if self.shouldFollowUserLocation {
                    self.region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                    self.shouldFollowUserLocation = false
                }
            }
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

struct MapView: View {
    @StateObject private var userLocationManager = UserLocationManager()
    let zoomStep: Double = 0.5
    var body: some View {
        Map(coordinateRegion: $userLocationManager.region, showsUserLocation: true, annotationItems: userLocationManager.groceryStores) { store in
            MapMarker(coordinate: store.coordinate, tint: .green)
        }
        .ignoresSafeArea()
        .onAppear {
        }
        
    }
}


