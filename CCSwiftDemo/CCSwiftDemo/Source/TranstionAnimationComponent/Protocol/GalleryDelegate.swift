//
//  GalleryDelegate.swift
//  CCSwiftDemo
//
//  Created by DoanDat on 1/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

public protocol GalleryDelegate
{
    func updateSelectedIndex(_ newIndex: Int)
    func updateImageSelected(_ imageSelected: UIImage)
}
