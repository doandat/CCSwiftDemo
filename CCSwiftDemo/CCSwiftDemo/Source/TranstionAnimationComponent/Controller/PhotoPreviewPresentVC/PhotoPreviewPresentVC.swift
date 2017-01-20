//
//  PhotoPreviewPresentVC.swift
//  CCSwiftDemo
//
//  Created by DoanDat on 1/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class PhotoPreviewPresentVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let kIdentifier = "PhotoShowCell"

    var urlImage = [String](){
        didSet
        {
            collectionView?.reloadData()
        }
    }
    
    var galleryDelegate: GalleryDelegate?
    var currentIdxPath: IndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let pIndexPath = self.currentIdxPath
        {
            /**
             please show xib file with max size (gussest iphone plus at xcode 8.2)
             
             because in viewWillAppear xib not load right size => collectionView.contentsize not enough => not setContentOffset right
             */
            
            self.collectionView.setContentOffset(CGPoint(x: UIScreen.main.bounds.size.width*CGFloat(pIndexPath.row), y: 0.0), animated: false)
            
            self.collectionView.setNeedsLayout()
            self.collectionView.layoutIfNeeded()
            
            self.collectionView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImageFromCell() -> UIImage?
    {
        let pCell = self.collectionView.visibleCells.first as? PhotoShowCell
        
        return pCell?.imvDes.image
    }
    
    func convertRectFromImage(image: UIImage?) -> CGRect
    {
        self.collectionView.reloadData()
        self.collectionView.setNeedsLayout()
        self.collectionView.layoutIfNeeded()
        
        guard let pImage = image else {
            
            return CGRect(x: 0, y: 64, width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
        }
        
        let checkShowFullHeight = pImage.size.height/pImage.size.width > (UIScreen.main.bounds.height - 64)/UIScreen.main.bounds.width
        
        if checkShowFullHeight
        {
            let widthFrame = self.collectionView.frame.size.height * pImage.size.width / pImage.size.height
            
            return CGRect(x: (self.collectionView.frame.size.width - widthFrame)/2, y: 64 , width: widthFrame, height: UIScreen.main.bounds.height - 64)
        }
        
        
        let heightFrame = self.collectionView.frame.size.width * pImage.size.height/pImage.size.width
        
        return CGRect(x: 0, y: 64 + (UIScreen.main.bounds.height - 64 - heightFrame)/2, width: self.collectionView.frame.size.width, height: heightFrame)
        
        
        
    }

    
    //
    func setupCollectionView()
    {
        self.edgesForExtendedLayout = UIRectEdge.all
        
        let pLayout = UICollectionViewFlowLayout()
        pLayout.minimumLineSpacing = 0.0
        pLayout.minimumInteritemSpacing = 0.0
        pLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pLayout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = pLayout
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = true
        self.collectionView.backgroundColor = UIColor.white
        
        //        self.collectionView.register(PhotoShowCell.self, forCellWithReuseIdentifier: kIdentifier)
        
        self.collectionView.register(UINib.init(nibName: kIdentifier, bundle: nil), forCellWithReuseIdentifier: kIdentifier)
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self;
    }
    
    func getCellSize() -> CGSize
    {
        
        self.collectionView.layoutIfNeeded()
        return CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height)
    }

    func setupBeforeDismiss()
    {
        let pIndexPath = self.collectionView.indexPathsForVisibleItems.first
        
        
        if let pIndexPath1 = pIndexPath
        {
            self.galleryDelegate?.updateSelectedIndex(pIndexPath1.row)
        }
        
        let pCell = self.collectionView.visibleCells.first as? PhotoShowCell
        
        if let pCell1 = pCell, let pImage = pCell1.imvDes.image
        {
            self.galleryDelegate?.updateImageSelected(pImage)
        }
    }
    

    
    @IBAction func actionBack(_ sender: Any)
    {
//        setupBeforeDismiss() //not need :)))
        
        self.dismiss(animated: true, completion: nil)
    }

}

extension PhotoPreviewPresentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let pCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: kIdentifier, for: indexPath) as! PhotoShowCell
        
        pCell.imvDes.contentMode = .scaleAspectFit
        pCell.imvDes.sd_setImage(with: URL(string: urlImage[indexPath.row]), placeholderImage: UIImage(named: "placeholder.jpg"))
        
        
        return pCell
        
    }
    
}


// MARK: ImageTransitionProtocol

extension PhotoPreviewPresentVC: ImageTransitionProtocol {
    
    func tranisitionSetup()
    {
        self.collectionView?.reloadData()
    }
    
    func tranisitionCleanup()
    {
        self.collectionView?.reloadData()
    }
    
    // 3: return the imageView window frame
    func imageWindowFrame() -> CGRect
    {
        return convertRectFromImage(image: getImageFromCell())
    
    }
}

