//
//  ImageTransitionProtocol.swift
//  CCSwiftDemo
//
//  Created by DoanDat on 1/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

public protocol ImageTransitionProtocol {
    func tranisitionSetup()
    func tranisitionCleanup()
    func imageWindowFrame() -> CGRect
}

