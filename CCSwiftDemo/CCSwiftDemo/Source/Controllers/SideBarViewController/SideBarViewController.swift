//
//  SideBarViewController.swift
//  BaseProjectSwift
//
//  Created by DatDV on 1/4/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class SideBarViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let sideBarCellIdentifier = "SideBarCellIdentifier"

    let dataSource = ["Home", "TranstionShowImageWithPresent", "Transition style list"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: setupTableView
    
    func setupTableView()
    {
        self.tableView.dataSource   = self
        self.tableView.delegate     = self
        tableView.register(UINib(nibName: String(describing: SideBarTableCell.self), bundle: nil), forCellReuseIdentifier: sideBarCellIdentifier)

    }
    
    //event didselect demo
    
    func pushVC()
    {
        let sideBarVC = SideBarViewController(nibName: nil, bundle: nil)
//        sideBarVC.isShowLeftMenu
        
        let baseNC = self.menuContainerViewController.centerViewController as! BaseNavigationController
        
        if (baseNC.topViewController != nil && baseNC.topViewController!.isKind(of: SideBarViewController.self))
        {
            return
        }
        
        baseNC.pushViewController(sideBarVC, animated: true)
        
    }

    
    func setHomeVCToCenter()
    {
        let collectionVC = HomeViewController(nibName: nil, bundle: nil)
        
        let baseNC = self.menuContainerViewController.centerViewController as! BaseNavigationController
//        baseNC.transitioningDelegate = nil
//        baseNC.delegate = nil
        baseNC.setViewControllers([collectionVC], animated: true);
        
    }
    
    func setGalleryPhotoPresentVCToCenter()
    {
        let collectionVC = GalleryPhotoTransitionPresentVC(nibName: nil, bundle: nil)
        
        let baseNC = self.menuContainerViewController.centerViewController as! BaseNavigationController
//        baseNC.transitioningDelegate = nil
//        baseNC.delegate = nil

        baseNC.setViewControllers([collectionVC], animated: true);

    }
    
    func setListTransitionVCToCenter()
    {
        let collectionVC = ListTransitionViewController(nibName: nil, bundle: nil)
        
        let baseNC = self.menuContainerViewController.centerViewController as! BaseNavigationController
        //        baseNC.transitioningDelegate = nil
        //        baseNC.delegate = nil
        
        baseNC.setViewControllers([collectionVC], animated: true);
        
    }

}


extension SideBarViewController: UITableViewDataSource, UITableViewDelegate
{
    //MARK: TableviewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: sideBarCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = dataSource[row]
        
        return cell
    }

    
    //MARK: TableviewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.menuContainerViewController.menuState = MFSideMenuStateClosed

        if indexPath.row == 0
        {
            setHomeVCToCenter()
            return
        }
        
        if indexPath.row == 1
        {
            setGalleryPhotoPresentVCToCenter()
            return
        }
        
        if indexPath.row == 2
        {
            setListTransitionVCToCenter()
            return
        }
        
        pushVC()

        
    }
}

