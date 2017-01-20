//
//  BaseNavigationController.swift
//  BaseProjectSwift
//
//  Created by DatDV on 1/4/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configNavigationBar()
    {
        self.navigationBar.isTranslucent    = false
        self.navigationBar.isOpaque         = true
        self.navigationBar.tintColor        = UIColor.white
        self.navigationBar.barTintColor     = UIColor(hex: kColorNavigation, alpha: 1.0)
    }
    

    func showShadowNav(isShow: Bool)
    {
        self.navigationBar.layer.shadowColor    = isShow ? UIColor.black.cgColor : UIColor.clear.cgColor
        self.navigationBar.layer.shadowOffset   = CGSize(width: 0.0, height: 1.0)
        self.navigationBar.layer.shadowOpacity  = 0.5
        
    }


}
