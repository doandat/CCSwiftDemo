//
//  BaseViewController.swift
//  BaseProjectSwift
//
//  Created by DatDV on 1/4/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

import SVProgressHUD

enum PositionBar {
    case PositionBarLeft
    case PositionBarRight
}


class BaseViewController: UIViewController {
    
    var leftMenuButton: UIButton?
    
    var leftBackButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = CommonUtil.getDisplayNameApp()

        configNavigationBar()
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config Navigationbar
    
    func configNavigationBar()
    {
        guard let baseNavigation: BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        
        baseNavigation.showShadowNav(isShow: true)
        
        self.configLeftBarButton()
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        
        baseNavigation.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]

    }
    
    
    func showMenuButtonNavigationBar()
    {
        leftMenuButton = UIButton(type: UIButtonType.custom)
        
        leftMenuButton!.setImage(UIImage(named: "btn_menu"), for: UIControlState.normal)

        leftMenuButton!.frame = CGRect(x: 0, y: 0, width: 18, height: 30)
        
        leftMenuButton!.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: leftMenuButton!)
        
        self.navigationItem.setLeftBarButtonItems([barButton], animated: true)
        
    }

    func configLeftBarButton()
    {
        leftMenuButton = UIButton(type: UIButtonType.custom)
        leftMenuButton!.setImage(UIImage(named: "btn_menu"), for: UIControlState.normal)
        leftMenuButton!.frame = CGRect(x: 0, y: 0, width: 18, height: 30)
        leftMenuButton!.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
        
        
        leftBackButton = UIButton(type: UIButtonType.custom)
        leftBackButton!.setImage(UIImage(named: "icon_back_button"), for: UIControlState.normal)
        leftBackButton!.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBackButton!.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let menuButton = UIBarButtonItem(customView: leftMenuButton!)
        let backButton = UIBarButtonItem(customView: leftBackButton!)
        
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = -15.0
        
        
        self.navigationItem.setLeftBarButtonItems([fixedSpace,backButton, menuButton], animated: true)
        
    }
    
    func showBackButtonNavigationBar()
    {
        leftBackButton = UIButton(type: UIButtonType.custom)
        leftBackButton!.setImage(UIImage(named: "icon_back_button"), for: UIControlState.normal)
        leftBackButton!.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBackButton!.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: leftBackButton!)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = -15.0
        
        self.navigationItem.setLeftBarButtonItems([fixedSpace,barButton], animated: true)
        
    }
    
    
    // MARK: Acion Button
    
    func menuAction(sender: UIButton!) {
        debugPrint("Menu tapped")
        self.menuContainerViewController.toggleLeftSideMenuCompletion{}
        
        
    }
    
    func backAction(sender: UIButton!) {
        debugPrint("Back tapped")
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: progressHUD
    
    func showLoading()
    {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func hideLoading()
    {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}
