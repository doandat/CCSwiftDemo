//
//  EndViewController.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/17/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

//    // MARK: - TransitionAnimatable
//    @IBInspectable  var _transitionAnimationType: String? {
//        didSet {
//            if let _transitionAnimationType = _transitionAnimationType {
//                transitionAnimationType = TransitionAnimationType(string: _transitionAnimationType)
//            }
//        }
//    }
//    open var transitionAnimationType: TransitionAnimationType = .none
//    
//    @IBInspectable open var transitionDuration: Double = 0.5
//    
//    open var interactiveGestureType: InteractiveGestureType = .none
//    @IBInspectable var _interactiveGestureType: String? {
//        didSet {
//            if let _interactiveGestureType = _interactiveGestureType {
//                interactiveGestureType = InteractiveGestureType(string: _interactiveGestureType)
//            }
//        }
//    }
//    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionDismiss(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
