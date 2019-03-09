//
//  UIColor+Facilities.swift
//  Forms
//
//  Created by Adriano Souza Costa on 09/03/19.
//

import UIKit

extension UIColor {
    
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}
