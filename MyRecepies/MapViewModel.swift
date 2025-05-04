//
//  MapViewModel.swift
//  MyRecepies
//
//  Created by Sri Ram Reddy Lankireddy on 15/04/24.
//
import MapKit
import Combine

class GroceryStoreMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion
    @Published var groceryStores: [MKPointAnnotation] = []
    private var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        updateRegion(center: latestLocation.coordinate)
        performSearch(center: latestLocation.coordinate)
    }
    
    private func updateRegion(center: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }

    private func performSearch(center: CLLocationCoordinate2D) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "grocery store"
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }

            DispatchQueue.main.async {
                self.groceryStores = response.mapItems.compactMap { item in
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    return annotation
                }
            }
        }
    }
}
