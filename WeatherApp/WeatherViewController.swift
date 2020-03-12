//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Aydın Sarıcan on 12.03.2020.
//  Copyright © 2020 Aydın Sarıcan. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage

class WeatherViewController: UIViewController {
    //90a89738b689176ff1dadfed71470604
    var key = ""
    var location: CLLocationCoordinate2D?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherService.getWeatherBy(lat: location!.latitude, lon: location!.longitude, key: key) { (response) in
            print(response)
            if response.response?.statusCode == 200 {
                if let resJson = response.value as? [String: AnyObject] {
                    if let cityName = resJson["name"] as? String {
                        self.cityLabel.text = cityName
                    }
                    if let main = resJson["main"] as? [String: AnyObject] {
                        if let temp = main["temp"] as? NSNumber {
                            self.tempLabel.text = "\(String(Int(truncating: temp)))°"
                        }
                    }
                    if let weathers = resJson["weather"] as? [AnyObject] {
                        if let weather = weathers.first as? [String: AnyObject] {
                            if let icon = weather["icon"] as? String {
                                self.weatherIconImageView.sd_setImage(with: URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png"), placeholderImage: UIImage(named: "10d"))
                                
                                print("Current icon: \(icon)")
                            }
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: nil, message: "Weather failed. Check your internet and key and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
