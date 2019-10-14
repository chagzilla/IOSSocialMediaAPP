//
//  EventDate.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/5/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class EventDate: UIViewController {

    
    
    var edit = false
    var EventPage:EventCreationPage?
    var EditPage:EventEditPage?
    
    
    let TimeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let Month:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let Time:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .time
        return datePicker
    }()
    
    let DoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(finishTime), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        button.isOpaque = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        view.isOpaque = false

        view.addSubview(TimeView)
        setupTimeView()
        view.addSubview(DoneButton)
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    @objc func finishTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let date = dateFormatter.string(from: Month.date)
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm a"
        let times = dateFormatter2.string(from: Time.date)
        if edit {
            self.EditPage?.data["DATE"] = date
            self.EditPage?.data["TIME"] = times
            
            if self.EditPage?.data["DATE"] != nil && self.EditPage?.data["TIME"] != nil {
                
                self.EditPage?.TimeButton.setTitle(self.EditPage?.data["DATE"] as? String, for: .normal)
                self.dismiss(animated: true, completion: nil)
                
            }
        } else {
            self.EventPage?.data["DATE"] = date
            self.EventPage?.data["TIME"] = times
            
            if self.EventPage?.data["DATE"] != nil && self.EventPage?.data["TIME"] != nil {
                
                self.EventPage?.TimeButton.setTitle(self.EventPage?.data["DATE"] as? String, for: .normal)
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    func setupTimeView() {
        
        TimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TimeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        TimeView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        TimeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        TimeView.addSubview(Month)
        TimeView.addSubview(Time)
        setupDatePickers()
        
    }
    
    func setupDatePickers() {
        
        Month.topAnchor.constraint(equalTo: TimeView.topAnchor).isActive = true
        Month.leftAnchor.constraint(equalTo: TimeView.leftAnchor).isActive = true
        Month.rightAnchor.constraint(equalTo: TimeView.rightAnchor).isActive = true
        Month.heightAnchor.constraint(equalTo: TimeView.heightAnchor, multiplier: 1/2).isActive = true
        
        Time.topAnchor.constraint(equalTo: Month.bottomAnchor).isActive = true
        Time.leftAnchor.constraint(equalTo: Month.leftAnchor).isActive = true
        Time.rightAnchor.constraint(equalTo: Month.rightAnchor).isActive = true
        Time.bottomAnchor.constraint(equalTo: TimeView.bottomAnchor).isActive = true
        
    }
    
    func setupButton() {
        
        DoneButton.topAnchor.constraint(equalTo: TimeView.bottomAnchor, constant: 25).isActive = true
        DoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        DoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        DoneButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
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
