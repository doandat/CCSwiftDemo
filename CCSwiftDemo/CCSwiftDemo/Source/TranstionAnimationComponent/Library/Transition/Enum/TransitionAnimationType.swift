//
//  TransitionAnimationType.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/16/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */

public enum TransitionAnimationType
{
    case none
    case systemRotate
    case systemSuckEffect
    case systemRippleEffect
    case explode(xFactor: CGFloat?, minAngle: CGFloat?, maxAngle: CGFloat?)
    case fade(direction: Direction)
    case fold(from: Direction, folds: Int?)
    case portal(direction: Direction, zoomScale: CGFloat?)
    case slide(to: Direction, isFade: Bool)
    case natGeo(to: Direction)
    case turn(from: Direction)
    case cards(direction: Direction)
    case flip(from: Direction)
    case systemCube(from: Direction)
    case systemFlip(from: Direction)
    case systemMoveIn(from: Direction)
    case systemPush(from: Direction)
    case systemReveal(from: Direction)
    case systemPage(type: PageType)
    case systemCameraIris(hollowState: HollowState)
    case showImage(to: Direction, isFade: Bool)

    public var stringValue: String
    {
        return String(describing: self)
    }

}

extension TransitionAnimationType: IBEnum
{
    public init(string: String?)
    {
        guard let string = string else
        {
            self = .none
            return
        }
        
        let nameAndParams = TransitionAnimationType.extractNameAndParams(from: string)
        
        let name = nameAndParams.name
        let params = nameAndParams.params
        
        switch name
        {
        case "systemrippleeffect":
            self = .systemRippleEffect
        case "systemsuckeffect":
            self = .systemSuckEffect
        case "explode":
            if params.count == 3 {
                if let xFactor = Double(params[0]),
                    let minAngle = Double(params[1]),
                    let maxAngle = Double(params[2]) {
                    let xFactor = CGFloat(xFactor)
                    let minAngle = CGFloat(minAngle)
                    let maxAngle = CGFloat(maxAngle)
                    self = .explode(xFactor: xFactor, minAngle: minAngle, maxAngle: maxAngle)
                    return
                }
            }
            self = .explode(xFactor: nil, minAngle: nil, maxAngle: nil)
        case "fade":
            self = .fade(direction: Direction(raw: params[safe: 0], defaultValue: .cross))
        case "systemcamerairis":
            self = .systemCameraIris(hollowState: HollowState(raw: params[safe: 0], defaultValue: .none))
        case "systempage":
            self = .systemPage(type: PageType(raw: params[safe: 0], defaultValue: .curl))
        case "systemrotate":
            self = .systemRotate
        case "systemcube":
            self = .systemCube(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "systemflip":
            self = .systemFlip(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "systemmovein":
            self = .systemMoveIn(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "systempush":
            self = .systemPush(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "systemreveal":
            self = .systemReveal(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "natgeo":
            self = .natGeo(to: Direction(raw: params[safe: 0], defaultValue: .left))
        case "turn":
            self = .turn(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "cards":
            self = .cards(direction: Direction(raw: params[safe: 0], defaultValue: .left))
        case "flip":
            self = .flip(from: Direction(raw: params[safe: 0], defaultValue: .left))
        case "fold":
            let direction = Direction(raw: params[safe: 0], defaultValue: .left)
            if let foldsString = params[safe: 1], let folds = Int(foldsString) {
                self = .fold(from: direction, folds: folds)
            } else {
                self = .fold(from: direction, folds: nil)
            }
        case "portal":
            let direction = Direction(raw: params[safe: 0], defaultValue: .left)
            if let zoomScaleString = params[safe: 1], let zoomScale = Double(zoomScaleString) {
                let zoomScale = CGFloat(zoomScale)
                self = .portal(direction: direction, zoomScale: zoomScale)
            } else {
                self = .portal(direction: direction, zoomScale: nil)
            }
        case "slide":
            let direction = Direction(raw: params[safe: 0], defaultValue: .left)
            let isFade = params.contains("fade")
            self = .slide(to: direction, isFade: isFade)
            
        case "showimage":
            let direction = Direction(raw: params[safe: 0], defaultValue: .left)
            let isFade = params.contains("fade")
            self = .showImage(to: direction, isFade: isFade)
            
        default:
            self = .none
        }
    }

}




// MARK: - `Direction`
extension TransitionAnimationType
{
    /**
     Direction: used to specify the direction for the transition
     */
    public enum Direction: String {
        case left
        case right
        case top
        case bottom
        case forward
        case backward
        case `in`
        case out
        case cross
     
        // Convert from direction to CATransition Subtype used in `CATransition`
        var caTransitionSubtype: String {
            switch self {
            case .left:
                return kCATransitionFromLeft
            case .right:
                return kCATransitionFromRight
            case .top:
                // The actual transition direction is oposite, need to reverse
                return kCATransitionFromBottom
            case .bottom:
                // The actual transition direction is oposite, need to reverse
                return kCATransitionFromTop
            default:
                return ""
            }
        }
        
        var isHorizontal: Bool {
            return self == .left || self == .right
        }
        
        
        static func fromString(forParams params: [String]) -> Direction? {
            if params.contains("left") {
                return .left
            } else if params.contains("right") {
                return .right
            } else if params.contains("top") {
                return .top
            } else if params.contains("bottom") {
                return .bottom
            } else if params.contains("forward") {
                return .forward
            } else if params.contains("backward") {
                return .backward
            }
            return nil
        }
        
        
        var opposite: Direction {
            switch self {
            case .left:
                return .right
            case .right:
                return .left
            case .top:
                return .bottom
            case .bottom:
                return .top
            case .in:
                return .out
            case .out:
                return .in
            case .forward:
                return .backward
            case .backward:
                return .forward
            case .cross:
                return .cross
            }
        }
    }
}

// MARK: - `TransitionHollowState`
extension TransitionAnimationType
{
    /**
     Hollow state: used to specify the hollow state for `systemCameraIris` transition
     */
    public enum HollowState: String {
        case none
        case open
        case close
    }
}


// MARK: - `PageType`
extension TransitionAnimationType {
    /**
     Page type: used to specify the page type for `systemPage` transition
     */
    public enum PageType: String {
        case curl
        case unCurl
    }
}


// MARK: - `SystemTransitionType`
extension TransitionAnimationType {
    /**
     System transition type: map to iOS built-in CATransition Type
     refer to http://iphonedevwiki.net/index.php/CATransition
     */
    public enum SystemTransitionType: String {
        case fade     // kCATransitionFade
        case moveIn   // kCATransitionMoveIn
        case push     // kCATransitionPush
        case reveal   // kCATransitionReveal
        case flip
        case cube
        case pageCurl
        case pageUnCurl
        case rippleEffect
        case suckEffect
        case cameraIris
        case cameraIrisHollowOpen
        case cameraIrisHollowClose
        case rotate
    }
}

extension TransitionAnimationType: Hashable {
    public var hashValue: Int {
        return stringValue.hashValue
    }
    
    public static func == (lhs: TransitionAnimationType, rhs: TransitionAnimationType) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }
}



