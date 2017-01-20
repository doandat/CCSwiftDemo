//
//  ListTransitionViewController.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/17/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit


class ListTransitionViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    let kIdentifier = "IdentifierCell"

    fileprivate var transitionAnimationsHeaders = [String]()
    fileprivate var transitionAnimations = [[String]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showMenuButtonNavigationBar()

        populateTransitionTypeData()
        
        setupTableView()

    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupTableView()
    {
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kIdentifier)
    }
    
    func didSelectRowAtIndexPath(indexPath: IndexPath)
    {
        
        let pVC = StartViewController(nibName: nil, bundle: nil)
        
        let toNavigationController = AnimatableNavigationController(rootViewController: pVC)
        toNavigationController.transitionDuration = 1.0
        toNavigationController.interactiveGestureType = .`default`
        
        
        let transitionString = transitionAnimations[indexPath.section][indexPath.row]
        
        let transitionAnimationType = TransitionAnimationType(string: transitionString)
        
        // Set the transition animation type for `AnimatableNavigationController`, used for Push/Pop transitions
        toNavigationController.transitionAnimationType = transitionAnimationType
        toNavigationController.navigationBar.topItem?.title = transitionString

        
        self.present(toNavigationController, animated: true, completion: nil)
        
        
    }
    

}

extension ListTransitionViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return transitionAnimations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transitionAnimations[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: kIdentifier, for: indexPath)
       
        cell.textLabel?.text = transitionAnimations[indexPath.section][indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAtIndexPath(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return transitionAnimationsHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
            header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        }
    }
        

}


private extension ListTransitionViewController {
    
    func populateTransitionTypeData() {
        transitionAnimationsHeaders.append("Fade")
        transitionAnimations.append(["Fade", "Fade(In)", "Fade(Out)"])
        transitionAnimationsHeaders.append("SystemCube")
        transitionAnimations.append(transitionTypeWithDirections(forName: "SystemCube"))
        transitionAnimationsHeaders.append("SystemFlip")
        transitionAnimations.append(transitionTypeWithDirections(forName: "SystemFlip"))
        transitionAnimationsHeaders.append("SystemMoveIn")
        transitionAnimations.append(transitionTypeWithDirections(forName: "SystemMoveIn"))
        transitionAnimationsHeaders.append("SystemPush")
        transitionAnimations.append(transitionTypeWithDirections(forName: "SystemPush"))
        transitionAnimationsHeaders.append("SystemReveal")
        transitionAnimations.append(transitionTypeWithDirections(forName: "SystemReveal"))
        transitionAnimationsHeaders.append("SystemPage")
        transitionAnimations.append(["SystemPage(Curl)", "SystemPage(UnCurl)"])
        transitionAnimationsHeaders.append("SystemCameraIris")
        transitionAnimations.append(["SystemCameraIris", "SystemCameraIris(HollowOpen)", "SystemCameraIris(HollowClose)"])
        transitionAnimationsHeaders.append("Fold")
        transitionAnimations.append(transitionTypeWithDirections(forName: "Fold"))
        transitionAnimationsHeaders.append("Portal")
        transitionAnimations.append(["Portal(Forward,0.3)", "Portal(Backward)"])
        transitionAnimationsHeaders.append("NatGeo")
        transitionAnimations.append(["NatGeo(Left)", "NatGeo(Right)"])
        transitionAnimationsHeaders.append("Turn")
        transitionAnimations.append(transitionTypeWithDirections(forName: "Turn"))
        transitionAnimationsHeaders.append("Cards")
        transitionAnimations.append(["Cards(Forward)", "Cards(Backward)"])
        transitionAnimationsHeaders.append("Flip")
        transitionAnimations.append(["Flip(Left)", "Flip(Right)"])
        transitionAnimationsHeaders.append("Slide")
        transitionAnimations.append(["Slide(Left, fade)", "Slide(Right)", "Slide(Top, fade)", "Slide(Bottom)"])
        transitionAnimationsHeaders.append("Others")
        transitionAnimations.append(["SystemRotate", "SystemRippleEffect", "SystemSuckEffect", "Explode", "Explode(10,-20,20)"])
    }
    
    func transitionTypeWithDirections(forName prefixName: String) -> [String] {
        return [prefixName + "(Left)", prefixName + "(Right)", prefixName + "(Top)", prefixName + "(Bottom)"]
    }
    
}

