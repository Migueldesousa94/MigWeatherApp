//
//  ViewController.swift
//  Mig Weather
//
//  Created by Miguel De Sousa on 5/25/19.
//  Copyright © 2019 Miguel De Sousa. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latt: UILabel!
    @IBOutlet weak var lonn: UILabel!
    @IBOutlet weak var wDescription: UILabel!
    @IBOutlet weak var wDescription1: UILabel!
    @IBOutlet weak var wDescription2: UILabel!
    @IBOutlet weak var weathericon2: UIImageView!
    @IBOutlet weak var weathericon: UIImageView!
    @IBOutlet weak var weathericon1: UIImageView!
    @IBOutlet weak var templabel2: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempLabel1: UILabel!
    @IBOutlet weak var text: UILabel!
    var datetext = "date"
   
   
    
    
    
    var locationManager = CLLocationManager()
    var CurrentLocation : CLLocation!
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as! CLLocation
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print(lon)
        print(lat)
       // self.latt.text = "\(lat)"
       // self.lonn.text = "\(lon)"
    }
        
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
      
        //Fetch current date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = NSDate()
        dateFormatter.locale = Locale(identifier: "en_US")
        datetext = (dateFormatter.string(from: date as Date))
        self.text.text = (self.datetext as? String)
       
        
        
        //Access API for London
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&units=imperial&appid=38fad0a6acef542f59fcca86fc3d7b2f")
            else {
                return
        }
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                        else {
                            return
                    }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any]
                        else {
                            return
                    }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)
                    let icon = (weatherDetails.first?["icon"] as? String)
                   
                    DispatchQueue.main.sync {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp, icon: icon)
                    }
                } catch { print("Error")}
            }
        }
        guard let url1 = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Tokyo&units=imperial&appid=38fad0a6acef542f59fcca86fc3d7b2f")
            else {
                return
        }
        let task1 = URLSession.shared.dataTask(with: url1) {
            (data, response, error) in
            if let data1 = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data1, options: []) as? [String : Any]
                        else {
                            return
                    }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any]
                        else {
                            return
                    }
                    let temp1 = Int(weatherMain["temp"] as? Double ?? 0)
                    let description1 = (weatherDetails.first?["description"] as? String)
                    let icon1 = (weatherDetails.first?["icon"] as? String)
                    
                    
                    DispatchQueue.main.sync {
                        self.setWeather1(weather: weatherDetails.first?["main"] as? String, description1: description1, temp1: temp1, icon1: icon1)
                    }
                } catch { print("Error")}
            }
        
        }
        
        
        
        guard let url2 = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=imperial&appid=38fad0a6acef542f59fcca86fc3d7b2f")
            else {
                return
        }
     
        
        let task2 = URLSession.shared.dataTask(with: url2) {
            (data, response, error) in
            if let data2 = data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data2, options: []) as? [String : Any]
                        else {
                            return
                    }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any]
                        else {
                            return
                    }
                    let temp2 = Int(weatherMain["temp"] as? Double ?? 0)
                    let description2 = (weatherDetails.first?["description"] as? String)
                    let icon2 = (weatherDetails.first?["icon"] as? String)
                    
                    
                    DispatchQueue.main.sync {
                        self.setWeather2(weather: weatherDetails.first?["main"] as? String, description2: description2, temp2: temp2, icon2: icon2)
                    }
                } catch { print("Error")}
            
            }
        }
        task1.resume()
        task.resume()
        task2.resume()
        
    }
        
    func setWeather(weather: String?, description: String?, temp: Int, icon: String? ) {
        wDescription.text = description ?? "..."
        tempLabel.text = "\(temp)° F"
        weathericon.image = UIImage(named: "\(icon)")
    }
    func setWeather1(weather: String?, description1: String?, temp1: Int, icon1: String? ) {
        wDescription1.text = description1 ?? "..."
        tempLabel1.text = "\(temp1)° F"
        weathericon1.image = UIImage(named: "\(icon1)")
    }
    func setWeather2(weather: String?, description2: String?, temp2: Int, icon2: String? ) {
        wDescription2.text = description2 ?? "..."
        templabel2.text = "\(temp2)° F"
        weathericon2.image = UIImage(named: "\(icon2)")
    }
    
       
        
}
   







