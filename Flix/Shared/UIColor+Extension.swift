//
//  UIColor+Extension.swift
//  Flix
//
//  Created by Pann Cherry on 4/9/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

extension UIColor {
    func image(size: CGSize = CGSize(width: 100, height: 30)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: size.height/2)
                .fill()
        }
    }
}
