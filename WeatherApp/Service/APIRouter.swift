//
//  APIRouter.swift
//  WeatherApp
//
//  Created by Aydın Sarıcan on 9.03.2020.
//  Copyright © 2020 Aydın Sarıcan. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
//    private var key: String {
//        return "90a89738b689176ff1dadfed71470604"
//    }
//    api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
    case getByCoordinate(lat: Double, lon: Double, key: String)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getByCoordinate:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getByCoordinate:
            return "weather"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getByCoordinate(let lat, let lon, let key):
            return ["lat": lat, "lon": lon, "appid": key, "units": "metric"]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try "http://api.openweathermap.org/data/2.5/".asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        print("Path: \(path)")
        print("Parameters: \(String(describing: parameters))")
        
        if self.method == Alamofire.HTTPMethod.post {
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: self.parameters)
        } else if self.method == Alamofire.HTTPMethod.put {
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: self.parameters)
        } else {
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
