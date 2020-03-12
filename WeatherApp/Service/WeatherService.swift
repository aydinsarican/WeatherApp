//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Aydın Sarıcan on 10.03.2020.
//  Copyright © 2020 Aydın Sarıcan. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherService {
    
    static func getWeatherBy(lat: Double, lon: Double, key: String, completion:@escaping (AFDataResponse<Any>) -> Void) {
        AF.request(APIRouter.getByCoordinate(lat: lat, lon: lon, key: key)).responseJSON { (response) in
            completion(response)
        }
    }
}
