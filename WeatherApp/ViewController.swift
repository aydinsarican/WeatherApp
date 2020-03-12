//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aydın Sarıcan on 9.03.2020.
//  Copyright © 2020 Aydın Sarıcan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiKeyTextField.adjust(radius: 5, borderWidth: 1, borderColor: #colorLiteral(red: 0.5176470588, green: 0.5725490196, blue: 0.6509803922, alpha: 1))
        apiKeyTextField.paddingLeft(padding: 14)
        continueButton.adjust(radius: 5, borderWidth: 1, borderColor: #colorLiteral(red: 0.3481967449, green: 0.3963935375, blue: 0.4443202019, alpha: 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        _ = checkLocationPermission()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func continueButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        if checkLocationPermission() {
            if apiKeyTextField.text != nil && apiKeyTextField.text != "" {
                self.performSegue(withIdentifier: "weatherSegue", sender: self)
            } else {
                let alert = UIAlertController(title: nil, message: "Enter api key", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: nil, message: "Unable to get location", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WeatherViewController {
            vc.key = apiKeyTextField.text!
            vc.location = location!
        }
    }
}

extension ViewController {
    func checkLocationPermission() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return false
            case .restricted,.denied:
                print("No access")
                let alert = UIAlertController(title: nil,
                                              message: "Please give the application location permission from the settings and try again.",
                                              preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Settings",
                                              style: UIAlertAction.Style.default, handler: { action in
                                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                                    return
                                                }
                                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                                        print("Settings opened: \(success)")
                                                    })
                                                }
                }))
                alert.addAction(UIAlertAction(title: "Tamam",
                                              style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                if location != nil {
                    return true
                } else {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                    locationManager.startUpdatingLocation()
                    return false
                }
            @unknown default:
                return false
            }
        } else {
            let alert = UIAlertController(title: nil,
                                          message: "Please open the location of your device and try again",
                                          preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
    }
}
