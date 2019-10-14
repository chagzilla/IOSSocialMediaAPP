//
//  FullSearchMap.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 3/8/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class FullSearchMap: UIViewController{
    
    var edit = false
    var EventPage:EventCreationPage?
    var EditPage:EventEditPage?
    
    var selectedPin:MKPlacemark? = nil
    
    var resultSearchController:UISearchController? = nil
    
    let locationManager = CLLocationManager()
    
    let DoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(finishLocation), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        button.isOpaque = false
        return button
    }()
    
    let worldMap: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        view.addSubview(worldMap)
        worldMap.delegate = self
        setupMap()
        
        view.addSubview(DoneButton)
        setupButton()
        
        let locationSearchTable = LocationSearchTable()
        locationSearchTable.mapView = worldMap
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true

        locationSearchTable.handleMapSearchDelegate = self
        
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MenuPage.back))
        backBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backBtn
        // Do any additional setup after loading the view.
    }
    
    @objc func back(_ sender: UIBarButtonItem)
    {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func finishLocation(){
        
        if selectedPin != nil {
            
            if edit {
                self.EditPage?.data["LOCATION"] = selectedPin?.title
                self.EditPage?.data["LONGITUDE"] = selectedPin?.coordinate.longitude
                self.EditPage?.data["LATITUDE"] = selectedPin?.coordinate.latitude
                if self.EditPage?.data["LOCATION"] != nil {
                    
                    self.EditPage?.LocationButton.setTitle(self.EventPage?.data["LOCATION"] as? String, for: .normal)
                    self.dismiss(animated: true, completion: nil)
            }
            }else {
                self.EventPage?.data["LOCATION"] = selectedPin?.title
                self.EventPage?.data["LONGITUDE"] = selectedPin?.coordinate.longitude
                self.EventPage?.data["LATITUDE"] = selectedPin?.coordinate.latitude
                if self.EventPage?.data["LOCATION"] != nil {
                    
                    self.EventPage?.LocationButton.setTitle(self.EventPage?.data["LOCATION"] as? String, for: .normal)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }  else {
            print("PICK A LOCATION")
        }
    }
    
    var doneButtonHeightAnchor: NSLayoutConstraint?
    
    func setupMap() {
        
        worldMap.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        worldMap.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        worldMap.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        worldMap.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func setupButton() {
        
        DoneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        DoneButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        DoneButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        doneButtonHeightAnchor = DoneButton.heightAnchor.constraint(equalToConstant: 0)
        doneButtonHeightAnchor?.isActive = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


