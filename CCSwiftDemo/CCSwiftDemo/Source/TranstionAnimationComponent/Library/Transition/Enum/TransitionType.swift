//
//  TransitionType.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/16/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

enum TransitionType
{
    case navigationTransition(UINavigationControllerOperation)
    case presentationTransition(PresentationOperation)
    case tabTransition(TabOperation)
}

enum PresentationOperation
{
    case presentation, dismissal
}

enum TabOperation
{
    case toLeft, toRight
}
