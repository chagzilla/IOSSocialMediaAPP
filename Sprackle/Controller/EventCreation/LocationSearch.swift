//
//  EventCreationPageOne.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/23/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import MapKit

class LocationSearch: UIViewController, UISearchBarDelegate {

    
    var location:String = ""
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    var EventPage:EventCreationPage?
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor.white
        return searchBar
    }()
    
    let worldMap: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let SearchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        view.isOpaque = false
        searchBar.delegate = self
        
        
        view.addSubview(SearchView)
        setupMapSearch()
        
        view.addSubview(DoneButton)
        setupButton()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view.
    }
    
    @objc func finishLocation(){
        self.EventPage?.data["LOCATION"] = self.location
        self.EventPage?.data["LONGITUDE"] = self.longitude
        self.EventPage?.data["LATITUDE"] = self.latitude
        if self.EventPage?.data["LOCATION"] != nil {
            
            self.EventPage?.LocationButton.setTitle(self.EventPage?.data["LOCATION"] as? String, for: .normal)
            self.dismiss(animated: true, completion: nil)
            
        } else {
            print("PICK A LOCATION")
        }
        
    }
    
    func setupMapSearch() {
        
        SearchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SearchView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        SearchView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        SearchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        
        SearchView.addSubview(searchBar)
        setupSearchBar()
        
        SearchView.addSubview(worldMap)
        setupMap()
        
        
    }
    
    func setupSearchBar() {
        
        searchBar.topAnchor.constraint(equalTo: SearchView.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: SearchView.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: SearchView.rightAnchor).isActive = true
        
    }
    
    func setupMap() {
        
        worldMap.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        worldMap.leftAnchor.constraint(equalTo: SearchView.leftAnchor).isActive = true
        worldMap.rightAnchor.constraint(equalTo: SearchView.rightAnchor).isActive = true
        worldMap.bottomAnchor.constraint(equalTo: SearchView.bottomAnchor).isActive = true
        
    }
    
    func setupButton() {
        
        DoneButton.topAnchor.constraint(equalTo: SearchView.bottomAnchor, constant: 25).isActive = true
        DoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        DoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        DoneButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start {
            (response, error) in
            
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            
            if response == nil
            {
                
            }
            else
            {
                
                let annotations = self.worldMap.annotations
                self.worldMap.removeAnnotations(annotations)
                
                self.latitude = response?.boundingRegion.center.latitude
                self.longitude = response?.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchText
                var address = response?.mapItems[0].placemark.title?.split(separator: ",")
                for x in address! {
                    print(x)
                }
                var count = 0
                while count < (address?.count)! && count < 3
                {
                    if count == 2
                    {
                        self.location += address![count]
                    }
                    else
                    {
                        self.location += address![count] + ", "
                        
                    }
                    count += 1
                }
                annotation.coordinate = CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
                self.worldMap.addAnnotation(annotation)
                print(self.location)
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.worldMap.setRegion(region, animated: true)
                
            }
        }
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
