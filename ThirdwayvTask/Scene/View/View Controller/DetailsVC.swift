//
//  DetailsVC.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import UIKit

protocol ProductDetailsView {
    func getProductImageHeight() -> CGFloat
    func getProductImage()
    
}

class DetailsVC: UIViewController {
    
    @IBOutlet weak var productImageHeight: NSLayoutConstraint!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice : UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    var productData : ProductData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.layer.cornerRadius = 10
        setupData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        productImage.addGestureRecognizer(tap)
        productImage.isUserInteractionEnabled = true
    }
    
    func setupData(){
        guard let productImageUrl = URL(string: (productData?.image?.url)!) else { return }
        DispatchQueue.main.async {
            self.productPrice.text = "\(self.productData?.price ?? 0) $"
            self.productDescription.text = self.productData?.productDescription
            self.productImageHeight.constant = CGFloat( self.productData?.image?.height ?? 0)
            self.productImage.loadImageWithURL(productImageUrl)
        }
    }
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

