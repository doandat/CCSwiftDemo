//
//  StartViewController.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/17/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let btnItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StartViewController.actionBack))
        
        
        self.navigationItem.setLeftBarButtonItems([btnItem], animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionBack()
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func actionPush(_ sender: Any)
    {
        let pVC = EndViewController(nibName: nil, bundle: nil)
        
        self.navigationController?.pushViewController(pVC, animated: true)
    }

    @IBAction func actionPresent(_ sender: Any)
    {
        let pVC = EndViewController(nibName: nil, bundle: nil)
        
        if let navigationController = self.navigationController as? AnimatableNavigationController
        {
            pVC.transitioningDelegate = TransitionPresenterManager.shared.retrievePresenter(transitionAnimationType: navigationController.transitionAnimationType, transitionDuration: navigationController.transitionDuration, interactiveGestureType: navigationController.interactiveGestureType)

        }
        

        
        self.present(pVC, animated: true, completion: nil)
    }
    
    @IBAction func actionDismiss(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
