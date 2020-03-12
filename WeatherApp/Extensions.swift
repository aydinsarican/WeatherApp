//
//  Extensions.swift
//  WeatherApp
//
//  Created by Aydın Sarıcan on 9.03.2020.
//  Copyright © 2020 Aydın Sarıcan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func adjust(radius: CGFloat, borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.black) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

extension UITextField {
    func paddingLeft(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
