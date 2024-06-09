//
//  ContactVC.swift
//  Luxcar
//
//  Created by mac on 30/01/2024.
//

import UIKit
import GoogleMaps

class ContactVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    var cordiator = CLLocationCoordinate2D()
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configerMapView(lat: 30.9658342, long: 31.161736)
    }
    func configerMapView(lat: Double, long: Double){
        do{
            let style = Bundle.main.url(forResource: "map_style", withExtension: "json")
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: style!)
        }catch let error{
            print(error.localizedDescription)
        }
        setMapViewAttributes()
        setupGoogleMaps(lat: lat, long: long)
    }
    
    func setMapViewAttributes(){
        mapView.animate(toZoom: 12)
        marker.icon = UIImage(named: "Logo")
        marker.map = mapView
    }
    
    func setupGoogleMaps(lat: Double , long: Double){
        cordiator = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.animate(toLocation: cordiator)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
