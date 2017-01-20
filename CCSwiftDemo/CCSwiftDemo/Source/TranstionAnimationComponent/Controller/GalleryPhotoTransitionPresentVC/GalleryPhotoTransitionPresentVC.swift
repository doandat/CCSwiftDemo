//
//  GalleryPhotoTransitionPresentVC.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/20/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

import SDWebImage

class GalleryPhotoTransitionPresentVC: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let kIdentifier = "ItemCollectionCell"

    var animationController: AnimationController?
    
    var interactiveAnimator: InteractiveAnimator?
    
    var urlImageList = [String]()
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Transition Present show Image"
        
        self.showMenuButtonNavigationBar()

        createImage()
        
        settingCollectionView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ========
    
    func createImage()
    {
        self.urlImageList = [
            "http://xqproduct.xiangqu.com/FrQbHmZzI-MGDQfQGQxrggRe8TUa?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/700x700",
            
            "http://xqproduct.xiangqu.com/Fj2kU4K_TS8Kvolme1FhZpmB8weh?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/FoYm07fprsGaSbbFYzAUXbAwMH09?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/1800x1200/",
            
            "http://xqproduct.xiangqu.com/FsMd6kTVFnqL5qhupgNeYu4veM39?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/Fk8Q5q_MxELt_dFWP8afoGI38kmr?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/750x500/",
            
            "http://xqproduct.xiangqu.com/FnR4RLXJjxLLWk4wvHC4WP5W_M4_?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/Fmsvn7L8TJ_m9RFgqyJHT40MZmVE?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/900x900/",
            
            "http://xqproduct.xiangqu.com/FkKSh-s49Lh767u9bDMCIUF4mIDJ?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/2500x1667/",
            
            "http://xqproduct.xiangqu.com/FsWsi3hPBTQnhOAVUIj-mF7WZZWE?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/700x864/",
            
            "http://xqproduct.xiangqu.com/FvpQ0MwpjqZfy2X-jvX4CtpyLtXN?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/780x518/",
            
            "http://xqproduct.xiangqu.com/FgeHAXZGHMPnnXpoVgCdFwXd3w6z?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/1600x1600/",
            
            "http://xqproduct.xiangqu.com/FnV26KwCeWQLKeM0fP_Z2ji8N7jx?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/Fuh3sKHDRUaLCHbopi25LpYrxRmr?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/FvUxhTJSYBuFloPwHM-OeM399bfV?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/700x1161/",
            
            "http://xqproduct.xiangqu.com/FveDrjGHXJ8kqH9LVqnm8mIc_Ebu?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/600x600/",
            
            "http://xqproduct.xiangqu.com/FjcO7UoUJfLkrk50CPnGnkTVtPnM?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/500x500/",
            
            "http://xqproduct.xiangqu.com/FkyTmgsMLpHVVtRb2swexk4Sog1x?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/640x981/",
            
            "http://xqproduct.xiangqu.com/FiuHw7kOWYitP0m4IoPZzJ3xIcmv?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/600x600/",
            
            "http://xqproduct.xiangqu.com/FvLmc4mXWkadpNRVJsRwlUabwFw1?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/Fku8nFowE8o6Q5KgIZ3Oa083riHo?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/460x460/",
            
            "http://xqproduct.xiangqu.com/Fjh9tUJKPi56PDopd5rnGnEd90Um?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/800x800/",
            
            "http://xqproduct.xiangqu.com/FsA0YbOm5fioYJIpyz8rsNoG7RVh?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/700x700/",
            
            "http://xqproduct.xiangqu.com/FnHGHyoDQC0xX8XhSLmB7tPx4lQk?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/750x750/"
        ]
    }
    
    func settingCollectionView()
    {
        self.collectionView.register(UINib.init(nibName: kIdentifier, bundle: nil), forCellWithReuseIdentifier: kIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    func removeProperty()
    {
        animationController = nil
        interactiveAnimator = nil
    }
    
    deinit {
        print("deinit GalleryPhotoTransitionPresentVC")
    }
    
}

extension GalleryPhotoTransitionPresentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.urlImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 5, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifier, for: indexPath) as! ItemCollectionCell
        
        pCell.imvDes.sd_setImage(with: URL(string: urlImageList[indexPath.row]), placeholderImage: UIImage(named: "placeholder.jpg"))
        
        
        return pCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         selectedIndex = indexPath.row
        
         let pVC = PhotoPreviewPresentVC(nibName: nil, bundle: nil)
    
         pVC.transitioningDelegate = self
         pVC.galleryDelegate = self
         pVC.urlImage = urlImageList
         pVC.currentIdxPath = IndexPath(row: selectedIndex!, section: 0)
        
         self.present(pVC, animated: true, completion: nil)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        self.animManager = nil;
        //
        //        self.view.bringSubview(toFront: self.collectionView)
        
        //        self.view.backgroundColor = UIColor.red
        
    }
    
}


// MARK: UIViewControllerTransitioningDelegate

extension GalleryPhotoTransitionPresentVC: GalleryDelegate {
    func updateSelectedIndex(_ newIndex: Int){
        selectedIndex = newIndex
        
    }
    
    func updateImageSelected(_ imageSelected: UIImage){

    }
}



// MARK: UIViewControllerTransitioningDelegate

// 1: Conforming to protocol
extension GalleryPhotoTransitionPresentVC: UIViewControllerTransitioningDelegate {
    
    // 2: presentation controller
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let pImage = (self.collectionView.cellForItem(at: IndexPath(row: selectedIndex!, section: 0)) as! ItemCollectionCell).imvDes.image
        
        let photoViewController = presented as! PhotoPreviewPresentVC
        
        animationController = AnimationController()
        
        animationController?.setupImageTransition( image: pImage!,
                                                  fromDelegate: self,
                                                  toDelegate: photoViewController, isDismiss: false)
        
        interactiveAnimator = InteractiveAnimatorFactory.makeInteractiveAnimator(interactiveGestureType: InteractiveGestureType.pan(from: InteractiveGestureType.GestureDirection.top), transitionType: .presentationTransition(.dismissal))
        interactiveAnimator?.connectGestureRecognizer(to: presented)

//        interactiveAnimator = InteractiveAnimatorFactory.makeInteractiveAnimator(interactiveGestureType: InteractiveGestureType.pan(from: InteractiveGestureType.GestureDirection.bottom), transitionType: .presentationTransition(.dismissal))
//        
//        interactiveAnimator?.connectGestureRecognizer(to: presented)

        return animationController
    }
    
    // 3: dismissing controller
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let photoViewController = dismissed as! PhotoPreviewPresentVC
        
        photoViewController.setupBeforeDismiss()
//        if dismissed.responds(to: Selector(("setupBeforeDismiss")))
//        {
//            dismissed.perform(Selector(("setupBeforeDismiss")))
//        }
//        
        var pImage = UIImage(named: "placeholder.jpg")
        
        if let pImg = photoViewController.getImageFromCell()
        {
            pImage = pImg
        }
        
        animationController = AnimationController()
        animationController?.setupImageTransition( image: pImage!,
                                                  fromDelegate: photoViewController,
                                                  toDelegate: self, isDismiss: true)
        return animationController
    }
    
    
    // MARK: - interaction controller
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let interactiveAnimator = interactiveAnimator, interactiveAnimator.interacting {
            return interactiveAnimator
        } else {
            return nil
        }
    }

    
}

// MARK: ImageTransitionProtocol

extension GalleryPhotoTransitionPresentVC: ImageTransitionProtocol {
    
    // 1: hide selected cell for tranisition snapshot
    func tranisitionSetup(){

        collectionView.reloadData()
        
        self.collectionView.scrollToItem(at: IndexPath(row: selectedIndex!, section: 0), at: UICollectionViewScrollPosition.centeredVertically, animated: false)
        
        
    }
    
    // 2: unhide selected cell after tranisition snapshot is taken
    func tranisitionCleanup(){
        collectionView.reloadData()
    }
    
    // 3: return window frame of selected image
    func imageWindowFrame() -> CGRect{
        let indexPath = IndexPath(row: selectedIndex!, section: 0)
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        
        var cellRect = attributes!.frame
        
        cellRect.size.height -= 45
        
        return collectionView.convert(cellRect, to: nil)
    }
}



