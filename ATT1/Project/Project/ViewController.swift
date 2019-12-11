//
//  ViewController.swift
//  CachedMap
//
//  Created by erumaru on 11/6/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import CoreData

import GoogleMaps

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var button: UIButton!
    var place:Place!
    
    // MARK: - Outlets
    lazy var mapView: GMSMapView = {
        let cameraPosition = GMSCameraPosition(latitude: 43.238643, longitude: 76.933594, zoom: 13)
        
        let view = GMSMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100), camera: cameraPosition)
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        markup()
        self.comment.isHidden=true
        self.button.isHidden=true
        //        saveData()
        //        fetchData()
        printMapData()
        addMarkers()
    }
    
    // MARK: - Configurations
    private func printMapData() {
        let request = NSFetchRequest<Place>(entityName: "Place")
        do {
            let data =  try AppDelegate.persistentContainer.viewContext.fetch(request)
            
            print("$$$$$$$$$$$$$$$$$$$$$$")
            print(data.map { "\($0.longitude) \($0.latitude) \($0.comment)" })
            print("$$$$$$$$$$$$$$$$$$$$$$")
        } catch {
            print(error)
        }
    }
    private func addMarkers() {
        let request = NSFetchRequest<Place>(entityName: "Place")
        do {
            let data =  try AppDelegate.persistentContainer.viewContext.fetch(request)
            for el in data{
                let position = CLLocationCoordinate2D(latitude: el.latitude, longitude: el.longitude)
                let marker = GMSMarker(position: position)
                marker.title = el.comment
                marker.map = mapView
                
            }
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func saveC(_ sender: Any) {
        
       self.place.comment=self.comment.text!
         print( "\(self.place.longitude) \(self.place.latitude) \(self.place.comment)" )
        let position = CLLocationCoordinate2D(latitude: self.place.latitude, longitude: self.place.longitude)
        let marker = GMSMarker(position: position)
        marker.title = place.comment
        marker.map = mapView
        try? AppDelegate.persistentContainer.viewContext.save()
        
        
        self.comment.isHidden=true
        self.button.isHidden=true
        self.comment.text=""
        
    }
    
    
    // MARK: - Markup
    private func markup() {
        view.backgroundColor = .red
        
        [mapView].forEach { view.addSubview($0) }

//        }
    }
}


extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.comment.isHidden=false
        self.button.isHidden=false
        self.place = Place(context: AppDelegate.persistentContainer.viewContext)
        self.place.latitude = coordinate.latitude
        self.place.longitude = coordinate.longitude
        
        
        
        
    }
}

