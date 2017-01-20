//
//  UIView+Extension.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/13/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

extension UIView
{
    func snapShotImg() -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0.0)
        
        let context = UIGraphicsGetCurrentContext()

        self.layer.render(in: context!)
        
        let snapShot = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return snapShot        
        
    }
}
